class RadSendgridStatusReceiver
  SPAM_REPORT = 'spamreport'.freeze
  SUPPRESSION_EVENTS = %w[dropped bounce spamreport].freeze

  def initialize(content)
    @content = content
    @notify = true

    check_events
  end

  def process!
    if host_name.blank?
      Rails.logger.info "sendgrid status for #{email}: missing host name, ignoring"
      return
    end

    if forward?
      Rails.logger.info "sendgrid status for #{email}: forwarding to #{host_name}"
      forward!
      return
    end

    return if missing_contact_log?

    process_status
    update_contact_log!
  end

  def email
    @content[:email].downcase
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def event
    @content[:event].downcase
  end

  def reason
    @content[:reason]
  end

  def record_id
    @content[:record_id]
  end

  def host_name
    @content[:host_name]
  end

  def suppression?
    SUPPRESSION_EVENTS.include?(event)
  end

  def timestamp
    DateTime.strptime(@content['timestamp'].to_s, '%s')
  end

  def user_agent
    @content[:useragent].presence || 'Unknown'
  end

  def url
    @content[:url]
  end

  private

    def process_status
      return unless deactivate_user?

      deactivate_user!
    end

    def deactivate_user?
      suppression? && user.present? && (spam_report? || user.stale? || user.needs_reactivate?)
    end

    def deactivate_user!
      @notify = false
      reason = deactivate_user_reason
      user.update! user_status: UserStatus.default_inactive_status
      Notifications::UserDeactivatedNotification.main(user: user, reason: reason).notify!
    end

    def deactivate_user_reason
      return 'they reported a recent email as spam' if spam_report?
      return 'a recent email to them failed and they have not accessed the system in quite a while' if user.stale?
      return 'a recent email to them failed and their account has expired due to inactivity' if user.needs_reactivate?

      raise 'unhandled deactivation reason'
    end

    def update_contact_log!
      return unless suppression?

      recipients = contact_log.contact_log_recipients.where(email: email)

      # if this occurs in the wild, we should see if there is a valid use case or was it an oversight that needs fixing
      # we can also add a uniqueness check to prevent the scenario further upstream
      raise "multiple recipients with same email #{email} for contact log #{contact_log.id}" if recipients.size > 1

      recipients.first.update! email_status: event, sendgrid_reason: reason, notify_on_fail: @notify
    end

    def contact_log_id
      @contact_log_id ||= @content[:contact_log_id]
    end

    def contact_log
      @contact_log ||= ContactLog.find_by(id: contact_log_id)
    end

    def missing_contact_log?
      contact_log_id.present? && contact_log.blank?
    end

    def check_events
      raise "unknown event type #{event}" unless all_events.include?(event)
    end

    def spam_report?
      event == SPAM_REPORT
    end

    def all_events
      SUPPRESSION_EVENTS + %w[open click]
    end

    def forward?
      host_name != RadConfig.host_name!
    end

    def forward!
      RadRetry.perform_request do
        response = forward_connection.post('/sendgrid_statuses') do |request|
          request.body = forward_body
        end

        raise "forward failed, code: #{response.status}, message: #{response.body}" unless response.status == 200
      end
    end

    def forward_connection
      @forward_connection ||= Faraday.new url: "#{forward_protocol}://#{host_name}", headers: forward_headers
    end

    def forward_protocol
      Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    end

    def forward_headers
      { 'Content-Type' => 'application/json' }
    end

    def forward_body
      { '_json' => [@content] }.to_json
    end
end

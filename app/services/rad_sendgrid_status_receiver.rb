class RadSendgridStatusReceiver
  SPAM_REPORT = 'spamreport'.freeze
  SUPPRESSION_EVENTS = %w[dropped bounce spamreport].freeze

  def initialize(content)
    @content = content
    check_events
  end

  def process!
    return unless host_matches?

    process_status!
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

    def process_status!
      if suppression? && user.present? && (spam_report? || user.stale?)
        user.update! user_status: UserStatus.default_inactive_status
        Rails.logger.info "sendgrid status: suppression received from stale user #{user.email}, deactivating"
      else
        Notifications::SendgridEmailStatusNotification.main(@content).notify!
      end
    end

    def update_contact_log!
      # TODO: what if contact_log is not found?
      return unless suppression? && contact_log.present?

      # TODO: find just the recipient that the suppression is applicable to
      contact_log.contact_log_recipients.each do |recipient|
        recipient.update! email_status: event
      end
    end

    def contact_log
      @contact_log ||= ContactLog.find(@content[:contact_log_id])
    end

    def check_events
      raise "unknown event type #{event}" unless all_events.include?(event)
    end

    def host_matches?
      if host_name.blank?
        Rails.logger.info "sendgrid status for #{email}: missing host name, ignoring"
        false
      elsif host_name == RadConfig.host_name!
        true
      else
        Rails.logger.info "sendgrid status for #{email}: host name doesn't match, ignoring - #{host_name}"
        false
      end
    end

    def spam_report?
      event == SPAM_REPORT
    end

    def all_events
      SUPPRESSION_EVENTS + %w[open click]
    end
end

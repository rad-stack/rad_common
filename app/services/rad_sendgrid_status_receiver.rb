class RadSendgridStatusReceiver
  SPAM_REPORT = 'spamreport'.freeze
  SUPPRESSION_EVENTS = %w[dropped bounce spamreport].freeze

  def initialize(content)
    @content = content
    check_events
  end

  def process!
    if forward?
      forward!
    else
      process_internal!
    end
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
    # legacy support for post_id, remove this eventually, see Task 41177
    @content[:record_id].presence || @content[:post_id]
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

    def process_internal!
      if suppression? && user.present? && (spam_report? || user.stale?)
        user.update! user_status: UserStatus.default_inactive_status
        Rails.logger.info "sendgrid suppression received from stale user #{user.email}, deactivating"
      else
        Notifications::SendgridEmailStatusNotification.main.notify! @content
      end
    end

    def check_events
      raise "unknown event type #{event}" unless all_events.include?(event)
    end

    def forward?
      host_name.present? && host_name != RadicalConfig.host_name!
    end

    def forward!
      RadicalRetry.perform_request do
        response = connection.post('/sendgrid_statuses') do |request|
          request.body = forward_body
        end

        raise "forward failed, code: #{response.status}, message: #{response.body}" unless response.status == 200
      end
    end

    def connection
      @connection ||= Faraday.new url: "#{protocol}://#{host_name}", headers: { 'Content-Type' => 'application/json' }
    end

    def spam_report?
      event == SPAM_REPORT
    end

    def protocol
      Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    end

    def forward_body
      { '_json' => [@content] }.to_json
    end

    def all_events
      SUPPRESSION_EVENTS + %w[open click]
    end
end

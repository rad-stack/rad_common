class RadSendgridStatusReceiver
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
    suppression_events.include?(event)
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
      Notifications::SendgridEmailStatusNotification.main.notify! @content
    end

    def check_events
      raise "unknown event type #{event}" unless all_events.include?(event)
    end

    def forward?
      host_name.present? && host_name != RadicalConfig.host_name!
    end

    def forward!
      RadicalRetry.perform_request do
        response = HTTParty.post("#{protocol}://#{host_name}/sendgrid_statuses",
                                 body: forward_body,
                                 headers: { 'Content-Type' => 'application/json' })

        raise "forward failed, code: #{response.code}, message: #{response.message}" unless response.code == 200
      end
    end

    def protocol
      Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    end

    def forward_body
      { '_json' => [@content] }.to_json
    end

    def all_events
      suppression_events + %w[open click]
    end

    def suppression_events
      ['dropped', 'bounce', 'spam report']
    end
end

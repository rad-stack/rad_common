class RadSendgridStatusReceiver
  attr_reader :content

  def initialize(content)
    @content = content

    raise "multiple emails detected: #{payload}" if valid? && email_count != 1
  end

  def process!
    Notifications::SendgridEmailStatusNotification.main.notify! payload
  end

  def valid?
    content.present?
  end

  private

    def email_count
      payload.pluck(:email).uniq.size
    end

    def payload
      content.map do |item|
        { email: item['email'].downcase,
          event: item['event'].downcase,
          type: item['type'].downcase,
          bounce_classification: item['bounce_classification'].downcase,
          reason: item['reason'] }
      end
    end
end

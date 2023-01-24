class RadSendgridStatusReceiver
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def process!
    Notifications::SendgridEmailStatusNotification.main.notify! payload
  end

  def valid?
    content.present?
  end

  private

    def payload
      content.map do |item|
        { email: item['email'].downcase,
          event: item['event'],
          type: item['type'],
          bounce_classification: item['bounce_classification'],
          reason: item['reason'] }
      end
    end
end

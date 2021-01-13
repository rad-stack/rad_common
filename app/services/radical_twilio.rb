class RadicalTwilio
  def send_sms(to:, message:)
    client.messages.create(from: from_number, to: to, body: full_body(message))
  end

  def send_mms(to:, message:, media_url:)
    client.messages.create(from: from_number_mms, to: to, body: full_body(message), media_url: media_url)
  end

  def send_robocall(to:, url:)
    client.calls.create(from: from_number, to: to, url: URI.encode(url))
  end

  def self.twilio_enabled?
    if ENV['TWILIO_ACCOUNT_SID'].blank? && ENV['TWILIO_AUTH_TOKEN'].blank? && ENV['TWILIO_PHONE_NUMBER'].blank?
      return false
    end

    if ENV['TWILIO_ACCOUNT_SID'].present? && ENV['TWILIO_AUTH_TOKEN'].present? && ENV['TWILIO_PHONE_NUMBER'].present?
      return true
    end

    raise 'inconsistent twilio config'
  end

  def from_number
    ENV.fetch('TWILIO_PHONE_NUMBER')
  end

  def from_number_mms
    ENV.fetch('TWILIO_MMS_PHONE_NUMBER')
  end

  private

    def client
      Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))
    end

    def full_body(message)
      return "#{message} - Reply STOP to unsubscribe" unless %w[. ! ?].include?(message[-1])

      "#{message} Reply STOP to unsubscribe."
    end
end

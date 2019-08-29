class RadicalTwilio
  def self.send_sms(from:, to:, message:)
    client.messages.create(from: from, to: to, body: message)
  end

  def self.send_robocall(from:, to:, url:)
    client.calls.create(from: from, to: to, url: URI::encode(url))
  end

  def self.client
    Twilio::REST::Client.new
  end

  def self.twilio_phone_number
    Company.main.next_phone_number
  end
end

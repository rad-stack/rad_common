class PhoneSMSSender
  attr_accessor :message, :mobile_phone, :from_number, :exception

  def initialize(message, mobile_phone)
    self.message = message
    self.mobile_phone = mobile_phone

    self.from_number = RadicalTwilio.next_phone_number

    raise 'The message failed: the mobile phone number is blank.' if mobile_phone.blank?
    raise "The message to #{mobile_phone} failed: the message is blank." if message.blank?
  end

  def send!
    RadicalRetry.perform_request do
      RadicalTwilio.send_sms from: from_number, to: to_number, message: message
    end

    true
  rescue Twilio::REST::RestError => e
    self.exception = e
    raise e.to_s unless blacklisted?

    false
  end

  private

    def to_number
      "+1#{mobile_phone.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}"
    end

    def blacklisted?
      exception.message.include?('violates a blacklist rule')
    end
end

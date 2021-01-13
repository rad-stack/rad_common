class PhoneSMSSender
  attr_accessor :message, :mobile_phone, :exception, :from_number

  def initialize(message, mobile_phone)
    self.message = message
    self.mobile_phone = mobile_phone

    raise 'The message failed: the mobile phone number is blank.' if mobile_phone.blank?
    raise "The message to #{mobile_phone} failed: the message is blank." if message.blank?
  end

  def send!
    twilio = RadicalTwilio.new
    self.from_number = twilio.from_number
    RadicalRetry.perform_request { twilio.send_sms to: to_number, message: message }

    log_event true
    true
  rescue Twilio::REST::RestError => e
    self.exception = e
    raise e.to_s unless blacklisted?

    log_event false
    false
  end

  private

    def to_number
      "+1#{mobile_phone.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}"
    end

    def blacklisted?
      exception.message.include?('violates a blacklist rule')
    end

    def log_event(success)
      TwilioLog.create! to_number: to_number,
                        from_number: from_number,
                        message: message,
                        success: success
    end
end

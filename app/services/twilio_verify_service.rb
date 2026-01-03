class TwilioVerifyService
  class << self
    def send_sms_token(phone_number)
      formatted_phone = RadTwilio.human_to_twilio_format(phone_number)

      client.verify.v2
            .services(RadConfig.twilio_verify_service_sid!)
            .verifications
            .create(to: formatted_phone, channel: 'sms')
    end

    def verify_sms_token(phone_number, code)
      formatted_phone = RadTwilio.human_to_twilio_format(phone_number)

      client.verify.v2
            .services(RadConfig.twilio_verify_service_sid!)
            .verification_checks
            .create(to: formatted_phone, code: code)
    end

    private

      def client
        Twilio::REST::Client.new(RadConfig.twilio_account_sid!, RadConfig.twilio_auth_token!)
      end
  end
end

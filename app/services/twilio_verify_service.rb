class TwilioVerifyService
  attr_reader :twilio_client, :twilio_account_sid, :twilio_auth_token, :twilio_verify_service_sid

  def self.send_sms_token(phone_number)
    new.twilio_verify_service.verifications.create(to: RadTwilio.human_to_twilio_format(phone_number), channel: 'sms')
  end

  def self.verify_sms_token(phone_number, token)
    formatted_phone = RadTwilio.human_to_twilio_format(phone_number)
    new.twilio_verify_service.verification_checks.create(to: formatted_phone, code: token)
  end

  def initialize
    @twilio_account_sid = Rails.application.credentials.twilio_account_sid || ENV.fetch('TWILIO_ACCOUNT_SID')
    @twilio_auth_token = Rails.application.credentials.twilio_auth_token || ENV.fetch('TWILIO_AUTH_TOKEN')

    @twilio_verify_service_sid = Rails.application.credentials.twilio_verify_service_sid ||
                                 ENV.fetch('TWILIO_VERIFY_SERVICE_SID')

    raise 'Missing Twilio credentials' unless @twilio_account_sid && @twilio_auth_token && @twilio_verify_service_sid

    @twilio_client = Twilio::REST::Client.new(@twilio_account_sid, @twilio_auth_token)
  end

  def twilio_verify_service
    twilio_client.verify.services(twilio_verify_service_sid)
  end
end

class TwilioVerifyService
  attr_reader :twilio_client, :twilio_account_sid, :twilio_auth_token, :twilio_verify_service_sid

  def self.send_token(to:, channel:)
    formatted_to = channel == 'sms' ? RadTwilio.human_to_twilio_format(to) : to
    new.twilio_verify_service.verifications.create(to: formatted_to, channel: channel)
  end

  def self.verify_token(to:, code:, channel:)
    formatted_to = channel == 'sms' ? RadTwilio.human_to_twilio_format(to) : to
    new.twilio_verify_service.verification_checks.create(to: formatted_to, code: code)
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

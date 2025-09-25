class TwilioVerifyService
  attr_reader :twilio_client, :twilio_account_sid, :twilio_auth_token, :twilio_verify_service_sid

  def self.send_sms_token(phone_number)
    new.twilio_verify_service.verifications.create(to: e164_format(phone_number), channel: 'sms')
  end

  def self.verify_sms_token(phone_number, token)
    verification_check = new.twilio_verify_service.verification_checks
                            .create(to: e164_format(phone_number), code: token)
    verification_check.status == 'approved'
  rescue StandardError => e
    Sentry.capture_exception(e)
    false
  end

  def self.verify_totp_setup(user, token)
    updated_factor = new.twilio_verify_service.entities([Rails.env, user.id].join('-'))
                        .factors(user.twilio_totp_factor_sid)
                        .update(auth_payload: token)

    if updated_factor.status == 'verified'
      user.update!(twilio_totp_verified: true)
      return true
    end

    false
  rescue StandardError => e
    Sentry.capture_exception(e)
    false
  end

  def self.verify_totp_token(user, token)
    return nil unless user.twilio_totp_verified?

    challenge = new.twilio_verify_service
                   .entities([Rails.env, user.id].join('-'))
                   .challenges
                   .create(factor_sid: user.twilio_totp_factor_sid, auth_payload: token)

    challenge.status == 'approved'
  rescue StandardError => e
    Sentry.capture_exception(e)
    false
  end

  def self.setup_totp_service(user)
    new_factor = new.twilio_verify_service_version_2
                    .entities([Rails.env, user.id].join('-'))
                    .new_factors
                    .create(friendly_name: user.to_s, factor_type: 'totp')

    user.update(twilio_totp_factor_sid: new_factor.sid)

    # Now in your app, take the new_factor.binding.uri
    # and generate a qr code to present to the user to scan to add the app to their authenticator app
    new_factor
  end

  def self.register_totp_service(user, token)
    # After user adds the app to their authenticator app, register the user by having them confirm a token
    # if this returns factor.status == 'verified', the user has been properly setup
    new.twilio_verify_service_version_2
       .entities([Rails.env, user.id].join('-'))
       .factors(user.twilio_totp_factor_sid)
       .update(auth_payload: token)
  end

  def self.e164_format(phone_number)
    "+1#{phone_number.gsub(/[^0-9a-z\\s]/i, '')}"
  end

  def initialize
    @twilio_account_sid = Rails.application.credentials.twilio_account_sid || ENV.fetch('TWILIO_ACCOUNT_SID', nil)
    @twilio_auth_token = Rails.application.credentials.twilio_auth_token || ENV.fetch('TWILIO_AUTH_TOKEN', nil)
    @twilio_verify_service_sid = Rails.application.credentials.twilio_verify_service_sid || ENV.fetch(
      'TWILIO_VERIFY_SERVICE_SID', nil
    )

    raise 'Missing Twilio credentials' unless @twilio_account_sid && @twilio_auth_token && @twilio_verify_service_sid

    @twilio_client = Twilio::REST::Client.new(@twilio_account_sid, @twilio_auth_token)
  end

  def twilio_verify_service
    twilio_client.verify.services(twilio_verify_service_sid)
  end

  def twilio_verify_service_version_2
    twilio_client.verify.v2.services(twilio_verify_service_sid)
  end

  delegate :e164_format, to: :class
end

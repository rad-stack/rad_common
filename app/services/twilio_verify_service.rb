class TwilioVerifyService
  def self.send_sms_token(phone_number)
    new.twilio_verify_service_version_2.verifications.create(to: e164_format(phone_number), channel: 'sms')
  end

  def self.verify_sms_token(phone_number, token)
    verification_check = new.twilio_verify_service_version_2.verification_checks
                            .create(to: e164_format(phone_number), code: token)
    verification_check.status == 'approved'
  rescue StandardError => e
    Sentry.capture_exception(e)
    false
  end

  def self.verify_totp_setup(user, token)
    updated_factor = new.twilio_verify_service_version_2.entities([Rails.env, user.id].join('-'))
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

    challenge = new.twilio_verify_service_version_2
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
    new_factor
  end

  def self.e164_format(phone_number)
    "+1#{phone_number.gsub(/[^0-9a-z\\s]/i, '')}"
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(RadConfig.twilio_account_sid!, RadConfig.twilio_auth_token!)
  end

  def twilio_verify_service_sid
    @twilio_verify_service_sid ||= RadConfig.twilio_verify_service_sid!
  end

  def twilio_verify_service_version_2
    twilio_client.verify.v2.services(twilio_verify_service_sid)
  end

  delegate :e164_format, to: :class
end

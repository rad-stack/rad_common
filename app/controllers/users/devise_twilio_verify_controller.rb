module Users
  class DeviseTwilioVerifyController < Devise::DeviseTwilioVerifyController
    def GET_verify_twilio_verify
      if @resource.twilio_totp_factor_sid.present?
        flash.now[:notice] = 'Check Authenticator App'
      elsif RadTwilio.send_verify_sms(@resource.mobile_phone)
        flash.now[:notice] = 'A verification token has been texted to you.'
      else
        flash.now[:error] = 'The verification code failed to send. Please click "Resend Text".'
      end

      super
    end
  end
end

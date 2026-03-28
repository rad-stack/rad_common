module Users
  class DeviseTwilioVerifyController < Devise::DeviseTwilioVerifyController
    def GET_verify_twilio_verify
      if should_send_sms?
        if RadTwilio.send_verify_sms(@resource.mobile_phone)
          flash.now[:notice] = 'A verification token has been texted to you.'
        else
          flash.now[:error] = 'The verification code failed to send. Please click "Resend Text".'
        end
      end

      render :verify_twilio_verify
    end

    private

      def should_send_sms?
        @resource.twilio_totp_factor_sid.blank? && @resource.mobile_phone.present?
      end
  end
end

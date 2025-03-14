module Users
  class DeviseTwilioVerifyController < Devise::DeviseTwilioVerifyController
    def GET_verify_twilio_verify
      if @resource.twilio_verify_sms?
        if RadTwilio.send_verify_sms(@resource.mobile_phone)
          flash.now[:notice] = 'A verification token has been texted to you.'
        else
          flash.now[:error] = 'The verification code failed to send. Please click "Resend Text".'
        end
      end

      super
    end

    private

      def check_resource_not_twilio_verify_enabled
        if @resource.twilio_verify_enabled?
          redirect_to after_twilio_verify_verified_path_for(resource)
        end
      end
  end
end

module Users
  class DeviseTwilioVerifyController < Devise::DeviseTwilioVerifyController
    def GET_verify_twilio_verify
      destination = two_factor_destination

      response = RadTwilio.send_verify_token(to: destination[:to], channel: destination[:channel]) if destination
      if response&.status == 'pending'
        message = destination[:channel] == 'sms' ? 'texted' : 'emailed'
        flash.now[:notice] = "A verification code has been #{message} to you."
      else
        flash.now[:error] = 'The verification code failed to send. Please click "Resend Code".'
      end

      super
    end
  end
end

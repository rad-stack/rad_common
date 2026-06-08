module Users
  class DeviseTwilioVerifyController < Devise::DeviseTwilioVerifyController
    def GET_verify_twilio_verify
      destination = two_factor_destination
      response = nil
      rate_limited = false

      if destination
        begin
          response = RadTwilio.send_verify_token(to: destination[:to], channel: destination[:channel])
        rescue RadTwilio::MaxSendAttemptsReachedError
          rate_limited = true
        end
      end

      if response&.status == 'pending'
        message = destination[:channel] == 'sms' ? 'texted' : 'emailed'
        flash.now[:notice] = "A verification code has been #{message} to you."
      elsif rate_limited
        flash.now[:error] = 'Too many verification code requests. Please wait a few minutes before trying again.'
      else
        flash.now[:error] = 'The verification code failed to send. Please click "Resend Code".'
      end

      super
    end
  end
end

module Users
  class DeviseAuthyController < Devise::DeviseAuthyController
    def GET_verify_authy
      if @resource.authy_sms?
        # TODO: check to make sure mobile_phone exists?
        response = RadicalTwilio.new.verify_send(@resource.mobile_phone)

        # TODO: handle failure
        # if response.ok?
          flash[:info] = 'A verification token has been texted to you.'
        # else
          # flash[:alert] = 'The verification code failed to send. Please click "Resend Text".'
        # end
      end

      super
    end
  end
end

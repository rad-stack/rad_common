module Users
  class TwoFactorAuthController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :check_otp_user

    def show
      skip_authorization
      @remember_device_days = RadConfig.twilio_verify_remember_device! / 1.day
    end

    def verify
      skip_authorization

      if @user.validate_and_consume_otp!(params[:otp_attempt])
        sign_in(@user)
        session.delete(:otp_user_id)
        # set_flash_message!(:notice, :signed_in) if is_flashing_format?
        redirect_to after_sign_in_path_for(@user)
      else
        flash.now[:alert] = 'Invalid two-factor code'
        render :show, status: :unprocessable_entity
      end
    end

    private

      def check_otp_user
        @user = User.find_by(id: session[:otp_user_id])

        if @user.blank?
          redirect_to new_user_session_path, alert: 'Please sign in first'
        end
      end
  end
end

module Users
  class TwoFactorAuthController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :check_otp_user

    def show
      skip_authorization
      send_sms_code
      @masked_phone = mask_phone_number(@user.mobile_phone)
    end

    def verify
      skip_authorization

      if verify_sms_code
        sign_in(@user)
        session.delete(:otp_user_id)
        flash[:success] = 'Signed in successfully' # TODO: should this be success or notice and toast or alert?
        redirect_to after_sign_in_path_for(@user)
      else
        flash.now[:alert] = 'Invalid two-factor code'
        render :show, status: :unprocessable_entity
      end
    end

    def resend
      skip_authorization

      if send_sms_code
        redirect_to users_two_factor_auth_path, notice: 'A new code has been sent to your phone'
      else
        redirect_to users_two_factor_auth_path, alert: 'Unable to send code. Please try again.'
      end
    end

    private

      def check_otp_user
        @user = User.find_by(id: session[:otp_user_id])
        return if @user.present?

        redirect_to new_user_session_path, alert: 'Please sign in first'
      end

      def send_sms_code
        return false if @user.mobile_phone.blank?

        # TODO: Re-enable RadTwilio.send_verify_sms once RadRateLimiter is fixed
        response = TwilioVerifyService.send_sms_token(@user.mobile_phone)
        response.status == 'pending'
      rescue StandardError => e
        Rails.logger.error "Failed to send SMS: #{e.message}"
        false
      end

      def verify_sms_code
        return false unless @user.mobile_phone.present? && params[:otp_attempt].present?

        response = TwilioVerifyService.verify_sms_token(@user.mobile_phone, params[:otp_attempt])
        response.status == 'approved'
      rescue StandardError => e
        Rails.logger.error "Failed to verify SMS: #{e.message}"
        false
      end

      def mask_phone_number(phone)
        return '' if phone.blank?

        # Show last 4 digits: (***) ***-1234
        phone.gsub(/\d(?=.{4})/, '*')
      end
  end
end

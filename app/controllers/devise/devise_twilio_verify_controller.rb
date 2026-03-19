module Devise
  class DeviseTwilioVerifyController < DeviseController
    prepend_before_action :find_resource, only: [
      :request_sms
    ]
    prepend_before_action :find_resource_and_require_password_checked, only: %i[
      GET_verify_twilio_verify POST_verify_twilio_verify
    ]

    include Devise::Controllers::Helpers

    def GET_verify_twilio_verify
      render :verify_twilio_verify
    end

    # verify 2fa
    def POST_verify_twilio_verify
      if @resource.mobile_phone.blank? || params[:token].blank?
        return handle_invalid_token :verify_twilio_verify, :invalid_token
      end

      begin
        verification_check = TwilioVerifyService.verify_sms_token(@resource.mobile_phone, params[:token])
        verification_check = verification_check.status == 'approved'
      rescue Twilio::REST::RestError
        verification_check = false
      end

      # Hack to reproduce authy functionality of being able to verify 2FA via SMS or TOTP
      # not ideal as there could be network delays, but there is currently no alternative
      if !verification_check && @resource.twilio_totp_factor_sid.present?
        verification_check = TwilioVerifyService.verify_totp_token(@resource, params[:token])
        verification_check = verification_check.status == 'approved'
      end

      if verification_check
        remember_device(@resource.id) if params[:remember_device].to_i == 1
        remember_user
        record_twilio_verify_authentication
        respond_with resource, location: after_sign_in_path_for(@resource)
      else
        handle_invalid_token :verify_twilio_verify, :invalid_token
      end
    end

    def request_sms
      if @resource.blank? || @resource.mobile_phone.blank?
        render json: { sent: false, message: "User couldn't be found." }
        return
      end

      verification = TwilioVerifyService.send_sms_token(@resource.mobile_phone)
      success = verification.status == 'pending'

      render json: {
        sent: success,
        message: success ? 'Token was sent.' : 'Token was not sent, please try again.'
      }
    end

    private

      def authenticate_scope!
        send(:"authenticate_#{resource_name}!", force: true)
        self.resource = send("current_#{resource_name}")
        @resource = resource
      end

      def find_resource
        @resource = send("current_#{resource_name}")
        return unless @resource.nil?

        @resource = resource_class.find_by(id: session["#{resource_name}_id"])
      end

      def find_resource_and_require_password_checked
        find_resource
        return unless @resource.nil? || session[:"#{resource_name}_password_checked"].to_s != 'true'

        redirect_to invalid_resource_path
      end

      def check_resource_not_twilio_verify_enabled
        return unless resource.twilio_verify_enabled

        redirect_to after_twilio_verify_verified_path_for(resource)
      end

    protected

      def after_twilio_verify_enabled_path_for(_resource)
        root_path
      end

      def after_twilio_verify_verified_path_for(resource)
        after_twilio_verify_enabled_path_for(resource)
      end

      def after_twilio_verify_disabled_path_for(_resource)
        root_path
      end

      def invalid_resource_path
        root_path
      end

      def handle_invalid_token(view, error_message)
        if @resource.respond_to?(:invalid_twilio_verify_attempt!) && @resource.invalid_twilio_verify_attempt!
          after_account_is_locked
        else
          set_flash_message(:error, error_message)
          render view
        end
      end

      def after_account_is_locked
        sign_out_and_redirect @resource
      end

      def remember_user
        return unless session.delete("#{resource_name}_remember_me") == true && @resource.respond_to?(:remember_me=)

        @resource.remember_me = true
      end
  end
end

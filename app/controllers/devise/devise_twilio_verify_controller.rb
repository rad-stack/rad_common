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
      destination = two_factor_destination
      return handle_invalid_token :verify_twilio_verify, :invalid_token if destination.nil? || params[:token].blank?

      begin
        verification_check = TwilioVerifyService.verify_token(to: destination[:to],
                                                              code: params[:token],
                                                              channel: destination[:channel])
        verification_check = verification_check.status == 'approved'
      rescue Twilio::REST::RestError
        verification_check = false
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
      destination = two_factor_destination
      return redirect_to invalid_resource_path if @resource.blank? || destination.nil?

      response = nil
      rate_limited = false

      begin
        response = RadTwilio.send_verify_token(to: destination[:to], channel: destination[:channel])
      rescue RadTwilio::MaxSendAttemptsReachedError
        rate_limited = true
      end

      if response&.status == 'pending'
        message = destination[:channel] == 'sms' ? 'texted' : 'emailed'
        flash.now[:notice] = "A verification code has been #{message} to you."
      elsif rate_limited
        flash.now[:error] = 'Too many verification code requests. Please wait a few minutes before trying again.'
      else
        flash.now[:error] = 'The verification code failed to send. Please try again.'
      end

      render :verify_twilio_verify
    end

    private

      def two_factor_destination
        return if @resource.blank?

        if @resource.mobile_phone.present?
          { to: @resource.mobile_phone, channel: 'sms' }
        elsif RadConfig.two_factor_auth_email_fallback? && @resource.email.present?
          { to: @resource.email, channel: 'email' }
        end
      end

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

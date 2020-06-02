class ApplicationController < ActionController::Base
  include RadbearController

  protect_from_forgery prepend: true, with: :exception

  protected

    def configure_devise_permitted_parameters
      additional_params = %i[first_name last_name authy_enabled mobile_phone avatar timezone]
      devise_parameter_sanitizer.permit(:sign_up, keys: additional_params)
      devise_parameter_sanitizer.permit(:account_update, keys: additional_params)

      return unless params[:action] == 'create'

      invite_params = %i[email first_name last_name external mobile_phone]
      devise_parameter_sanitizer.permit(:invite) { |u| u.permit(invite_params) }
    end
end

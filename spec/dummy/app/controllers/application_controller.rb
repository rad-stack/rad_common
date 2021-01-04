class ApplicationController < ActionController::Base
  include RadbearController

  before_action :authenticate_user!

  protect_from_forgery prepend: true, with: :exception

  protected

    def configure_devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: additional_params)
      devise_parameter_sanitizer.permit(:account_update, keys: additional_params)
      devise_parameter_sanitizer.permit(:invite, keys: %i[first_name last_name external mobile_phone])
    end

    def additional_params
      %i[first_name last_name authy_enabled mobile_phone avatar timezone]
    end
end

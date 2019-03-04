class ApplicationController < ActionController::Base
  include RadbearController
  include RadbearAuditsController

  protect_from_forgery prepend: true, with: :exception

  ensure_authorization_performed except: %i[home global_search global_search_result],
                                 if: :auditing_security?, unless: :devise_controller?

  protected

    def auditing_security?
      controller_name = self.class
      [RadCommon::SendgridController].exclude?(controller_name)
    end

    def configure_devise_permitted_parameters
      additional_params = %i[first_name last_name authy_enabled mobile_phone avatar]
      devise_parameter_sanitizer.permit(:sign_up, keys: additional_params)
      devise_parameter_sanitizer.permit(:account_update, keys: additional_params)

      return unless params[:action] == 'create'

      invite_params = %i[email first_name last_name external]
      devise_parameter_sanitizer.permit(:invite) { |u| u.permit(invite_params) }
    end
end

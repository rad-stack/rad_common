class ApplicationController < ActionController::Base
  include RadbearController
  include RadbearAuditsController

  protect_from_forgery prepend: true, with: :exception
  ensure_authorization_performed except: %i[home global_search global_search_result], if: :auditing_security?, unless: :devise_controller?

  protected

    def auditing_security?
      controller_name = self.class
      [RadCommon::SendgridController].exclude?(controller_name)
    end

    def configure_devise_permitted_parameters
      registration_params = %i[first_name last_name email password password_confirmation authy_enabled mobile_phone avatar]

      if params[:action] == 'update'
        devise_parameter_sanitizer.permit(:account_update) do |user_params|
          user_params.permit(registration_params + [:current_password])
        end
      elsif params[:action] == 'create'
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
          user_params.permit(registration_params)
        end
      end
    end
end

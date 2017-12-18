class ApplicationController < ActionController::Base
  include RadbearAuditsController

  protect_from_forgery prepend: true, with: :null_session
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  ensure_authorization_performed except: :home, if: :auditing_security?, unless: :devise_controller?

  def current_auth_user
    current_user
  end

  protected

    def auditing_security?
      Rails.env != :production
    end

    def configure_devise_permitted_parameters
      registration_params = %i[first_name last_name email username password password_confirmation optional_emails]

      if params[:action] == 'update'
        devise_parameter_sanitizer.permit(:account_update) do |user_params|
          user_params.permit(registration_params) + [:current_password]
        end
      elsif params[:action] == 'create'
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
          user_params.permit(registration_params)
        end
      end
    end
end

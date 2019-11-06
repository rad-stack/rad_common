class ApplicationController < ActionController::Base
  after_action :verify_authorized, unless: :devise_controller?

  # TODO: after_action :verify_policy_scoped, only: :index

  include RadbearController
  include RadbearAuditsController

  protect_from_forgery prepend: true, with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def configure_devise_permitted_parameters
      additional_params = %i[first_name last_name authy_enabled mobile_phone avatar timezone]
      devise_parameter_sanitizer.permit(:sign_up, keys: additional_params)
      devise_parameter_sanitizer.permit(:account_update, keys: additional_params)

      return unless params[:action] == 'create'

      invite_params = %i[email first_name last_name external mobile_phone]
      devise_parameter_sanitizer.permit(:invite) { |u| u.permit(invite_params) }
    end

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || root_path)
    end
end

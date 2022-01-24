module RadbearController
  extend ActiveSupport::Concern
  include Pundit

  included do
    before_action :configure_devise_permitted_parameters, if: :devise_controller?
    before_action :set_sentry_user_context
    around_action :user_time_zone, if: :current_user
    after_action :verify_authorized, unless: :devise_controller?
    after_action :verify_policy_scoped, only: :index

    rescue_from Pundit::NotAuthorizedError do
      # the application.rb config in the docs to do the same thing doesn't work
      # https://github.com/varvet/pundit#rescuing-a-denied-authorization-in-rails
      render file: Rails.root.join('public/403.html'), formats: [:html], status: :forbidden, layout: false
    end

    impersonates :user
  end

  protected

    def configure_devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: devise_account_params)
      devise_parameter_sanitizer.permit(:account_update, keys: devise_account_params)
      devise_parameter_sanitizer.permit(:invite, keys: devise_invite_params)
    end

    def devise_account_params
      %i[first_name last_name authy_enabled mobile_phone avatar timezone]
    end

    def devise_invite_params
      %i[first_name last_name external mobile_phone]
    end

    def set_sentry_user_context
      return unless current_user

      Sentry.set_user(id: current_user.id, email: current_user.email, name: current_user.to_s)
    end

    def user_time_zone(&block)
      Time.use_zone(current_user.timezone, &block)
    end
end

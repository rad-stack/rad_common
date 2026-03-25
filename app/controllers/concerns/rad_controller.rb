module RadController
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    before_action :configure_devise_permitted_parameters, if: :devise_controller?
    before_action :set_sentry_user_context
    before_action :set_assistant_session_context
    before_action :check_ip_address_timezone, if: :user_signed_in?
    around_action :user_timezone
    around_action :switch_locale, if: :switch_languages?
    after_action :verify_authorized, unless: :devise_controller?
    after_action :verify_policy_scoped, only: :index

    rescue_from Pundit::NotAuthorizedError do |exception|
      # the application.rb config in the docs to do the same thing doesn't work
      # https://github.com/varvet/pundit#rescuing-a-denied-authorization-in-rails

      Sentry.capture_exception exception if report_sentry_access_denied?
      render file: Rails.root.join('public/403.html'), formats: [:html], status: :forbidden, layout: false
    end

    helper_method :show_assistant_nav?

    impersonates :user
  end

  def set_assistant_session_context(chat_class: 'LLM::ChatTypes::SystemChat', chat_scope: nil)
    @chat_class = chat_class
    @chat_scope = chat_scope
  end

  def show_assistant_nav?
    assistant_enabled = RadConfig.open_ai_api_key.present? && current_user && policy(AssistantSession).new?
    return true if assistant_enabled && RadConfig.rad_system_chat_enabled?

    @chat_class.present? && @chat_class != 'LLM::ChatTypes::SystemChat'
  end

  protected

    def configure_devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: devise_sign_up_params)
      devise_parameter_sanitizer.permit(:account_update, keys: devise_account_params)
      devise_parameter_sanitizer.permit(:invite, keys: devise_invite_params)
    end

    def devise_sign_up_params
      %i[first_name last_name mobile_phone initial_security_role_id]
    end

    def devise_account_params
      %i[first_name last_name mobile_phone avatar timezone language]
    end

    def devise_invite_params
      %i[first_name last_name mobile_phone initial_security_role_id] + RadConfig.additional_user_params!
    end

    def set_sentry_user_context
      return unless current_user

      Sentry.set_user(id: true_user.id, email: true_user.email, name: sentry_user_name)
    end

    def sentry_user_name
      return true_user.to_s unless impersonating?

      "#{true_user} impersonating #{current_user}"
    end

    def report_sentry_access_denied?
      (Rails.env.production? || Rails.env.staging?) && !impersonating? && user_signed_in?
    end

    def impersonating?
      current_user != true_user
    end

    def check_ip_address_timezone
      return unless RadConfig.timezone_detection?
      return if impersonating?

      UserTimezone.new(current_user).check_user!(request.remote_ip)
    end

    def user_timezone(&)
      timezone = current_user.present? ? current_user.timezone : Company.main.timezone
      Time.use_zone(timezone, &)
    end

    def search_params
      params.except(:commit, :format, :action, :controller, 'utf8').permit!
    end

    def report_generating_message
      'Your report is generating. An email will be sent when it is ready.'
    end

    def switch_languages?
      RadConfig.switch_languages?
    end

    def switch_locale(&)
      locale = params[:locale] || current_user.try(:locale) || I18n.default_locale
      I18n.with_locale(locale, &)
    end

    def redirect_to_path(record)
      return params[:redirect_to] if params[:redirect_to].present?

      record
    end
end

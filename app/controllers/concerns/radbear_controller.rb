module RadbearController
  extend ActiveSupport::Concern

  included do
    before_action :configure_devise_permitted_parameters, if: :devise_controller?
    before_action :set_raven_user_context
  end

  protected

    def set_raven_user_context
      return unless current_user

      Raven.context.user = { user_id: current_user.id }
    end
end

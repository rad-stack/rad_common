module RadbearController
  extend ActiveSupport::Concern

  included do
    before_action :configure_devise_permitted_parameters, if: :devise_controller?
    helper_method :current_member
  end

  def current_member
    current_user
  end
end

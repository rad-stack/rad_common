class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super
    Notification.new_user_signed_up(resource) if resource.errors.empty?
  end
end

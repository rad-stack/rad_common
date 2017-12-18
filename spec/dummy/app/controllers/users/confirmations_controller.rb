class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super
    resource.notify_new_user if resource.errors.empty?
  end
end

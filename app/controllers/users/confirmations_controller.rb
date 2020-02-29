class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super
    Notifications::NewUserSignedUpNotification.new.notify!(resource) if resource.errors.empty?
  end
end

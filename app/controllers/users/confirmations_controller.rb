module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super
      Notifications::NewUserSignedUpNotification.main.notify!(resource) if resource.errors.empty?
    end
  end
end

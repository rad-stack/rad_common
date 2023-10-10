module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super
      Notifications::NewUserSignedUpNotification.main(resource).notify! if resource.errors.empty?
    end
  end
end

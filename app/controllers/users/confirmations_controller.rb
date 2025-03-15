module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super
      Notifications::NewUserSignedUpNotification.main(resource).notify! if resource.errors.empty?
      resource.update(invitation_accepted_at: resource.confirmed_at, invitation_token: nil) unless resource.invitation_accepted?
    end
  end
end

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super
      Notifications::NewUserSignedUpNotification.main(resource).notify! if resource.errors.empty?
      resource.update(invitation_accepted_at: resource.confirmed_at, invitation_token: nil) unless resource.invitation_accepted?
    end

    private

      def confirming_email_change?
        resource.unconfirmed_email_previously_changed?
      end
  end
end

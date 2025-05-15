module Notifications
  class UserAcceptedInvitationNotification < ::NotificationType
    def mailer_message
      "#{payload} has accepted the invitation to join #{app_name}."
    end

    private

      def app_name
        payload.external? ? RadConfig.portal_app_name!(payload) : RadConfig.app_name!
      end
  end
end

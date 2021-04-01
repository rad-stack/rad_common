module Notifications
  class UserAcceptedInvitationNotification < ::NotificationType
    def mailer_message
      "#{payload} has accepted the invitation to join #{app_name}."
    end

    private

      def app_name
        payload.internal? ? RadCommon::AppInfo.new.app_name : I18n.t(:portal_app_name)
      end
  end
end

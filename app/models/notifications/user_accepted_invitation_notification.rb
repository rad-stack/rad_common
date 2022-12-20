module Notifications
  class UserAcceptedInvitationNotification < ::NotificationType
    def mailer_message
      "#{payload} has accepted the invitation to join #{RadicalConfig.app_name!}."
    end
  end
end

module Notifications
  class UserAcceptedInvitationNotification < ::NotificationType
    def mailer_message
      "#{payload} has accepted the invitation to join #{RadConfig.app_name!}."
    end

    def mailer_contact_log_from_user
      payload
    end
  end
end

module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def mailer_method
      'new_user_signed_up'
    end
  end
end

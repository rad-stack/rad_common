module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      payload[:recipient_ids]
    end

    def subject_record
      payload[:user]
    end

    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'new_user_signed_up'
    end
  end
end

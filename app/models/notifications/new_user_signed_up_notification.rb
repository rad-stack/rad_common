module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def default_notification_methods
      %i[email sms]
    end

    def absolute_user_ids
      payload[:recipient_ids]
    end

    def subject_record
      user
    end

    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'new_user_signed_up'
    end

    def sms_content
      user.new_user_signed_up_subject
    end

    def feed_content
      sms_content
    end

    private

      def user
        payload[:user]
      end
  end
end

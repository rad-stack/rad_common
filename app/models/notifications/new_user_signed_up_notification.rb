module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def add_defaults
      self.default_email = true
      self.default_sms = true
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
      "#{user.new_user_signed_up_sms}: #{subject_url}"
    end

    def feed_content
      user.new_user_signed_up_sms
    end

    private

      def user
        payload[:user]
      end
  end
end

module Notifications
  class SendgridEmailStatusNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'sendgrid_status'
    end

    def feed_content
      "SendGrid Email Status for #{feed_content_item}"
    end

    def subject_record
      user
    end

    private

      def feed_content_item
        user.presence || email
      end

      def user
        User.find_by(email: email)
      end

      def email
        payload[:email]
      end
  end
end

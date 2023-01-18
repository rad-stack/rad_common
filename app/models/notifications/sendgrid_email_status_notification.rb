module Notifications
  class SendgridEmailStatusNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'sendgrid_status'
    end

    def feed_content
      "SendGrid Email Status for #{emails}"
    end

    def subject_record
      User.find_by(email: payload.first[:email])
    end

    private

      def emails
        payload.pluck(:email).to_sentence
      end
  end
end

module Notifications
  class SendgridEmailStatusNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'sendgrid_status'
    end

    def subject_record
      nil
    end
  end
end

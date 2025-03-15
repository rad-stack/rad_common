module Notifications
  class HighDuplicatesNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'high_duplicates'
    end

    def sms_enabled?
      false
    end

    def subject_record
      nil
    end
  end
end

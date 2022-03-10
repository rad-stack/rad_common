module Notifications
  class InvalidDataWasFoundNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'global_validity'
    end

    def subject_record
      nil
    end
  end
end

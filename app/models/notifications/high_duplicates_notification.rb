module Notifications
  class HighDuplicatesNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'high_duplicates'
    end

    def subject_record
      nil
    end

    # TODO: check/fix all notification flavors
  end
end

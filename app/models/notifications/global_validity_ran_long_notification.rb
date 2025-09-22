module Notifications
  class GlobalValidityRanLongNotification < DeveloperNotification
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'global_validity_ran_long'
    end

    def subject_record
      nil
    end
  end
end

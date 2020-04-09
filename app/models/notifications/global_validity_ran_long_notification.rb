module Notifications
  class GlobalValidityRanLongNotification < ::NotificationType
    def mailer_method
      'global_validity_ran_long'
    end

    def subject_record
      nil
    end
  end
end

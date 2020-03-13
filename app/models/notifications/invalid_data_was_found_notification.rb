module Notifications
  class InvalidDataWasFoundNotification < ::NotificationType
    def mailer_method
      'global_validity'
    end

    def subject_record
      nil
    end
  end
end

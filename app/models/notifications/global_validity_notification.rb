module Notifications
  class GlobalValidityNotification < ::NotificationType
    def mailer_method
      'global_validity'
    end

    def feed_content
      'Invalid data was found in the system.'
    end

    def feed_record
      nil
    end
  end
end

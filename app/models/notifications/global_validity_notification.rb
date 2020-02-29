module Notifications
  class GlobalValidityNotification < ::NotificationType
    def mailer_class
      'RadbearMailer'
    end

    def mailer_method
      'global_validity'
    end

    def feed_content
      'Invalid data was found in the system.'
    end

    def feed_record
      nil
    end

    def sms_content
      feed_content
    end
  end
end

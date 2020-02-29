module Notifications
  class GlobalValidityNotification < ::NotificationType
    class << self
      protected

        def mailer_class
          'RadbearMailer'
        end

        def mailer_method
          'global_validity'
        end

        def feed_content(_payload)
          'Invalid data was found in the system.'
        end

        def feed_record(_payload)
          nil
        end

        def sms_content(payload)
          feed_content(payload)
        end

        def exclude_user_ids(_payload)
          []
        end
    end
  end
end

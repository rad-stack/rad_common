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

        def feed_content(_subject)
          'Invalid data was found in the system.'
        end

        def sms_content(subject)
          feed_content(subject)
        end

        def exclude_user_ids(_subject)
          []
        end
    end
  end
end

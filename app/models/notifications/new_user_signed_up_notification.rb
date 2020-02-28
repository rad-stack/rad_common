module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    class << self
      protected

        def mailer_class
          'RadbearMailer'
        end

        def mailer_method
          'new_user_signed_up'
        end

        def feed_content(subject)
          # TODO: add link
          "#{subject} signed up."
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

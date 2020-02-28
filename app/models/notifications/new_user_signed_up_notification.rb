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
          "#{subject} signed up."
        end

        def feed_record(subject)
          subject
        end

        def sms_content(subject)
          "#{subject} signed up: #{Rails.application.routes.url_helpers.user_url(subject)}"
        end

        def exclude_user_ids(_subject)
          []
        end
    end
  end
end

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

        def feed_content(payload)
          "#{payload} signed up."
        end

        def feed_record(payload)
          payload
        end

        def sms_content(payload)
          "#{payload} signed up: #{Rails.application.routes.url_helpers.user_url(payload)}"
        end

        def exclude_user_ids(_payload)
          []
        end
    end
  end
end

module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def mailer_class
      'RadbearMailer'
    end

    def mailer_method
      'new_user_signed_up'
    end

    def feed_content
      "#{payload} signed up."
    end

    def feed_record
      payload
    end

    def sms_content
      "#{payload} signed up: #{Rails.application.routes.url_helpers.user_url(payload)}"
    end
  end
end

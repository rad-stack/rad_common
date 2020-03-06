module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def mailer_method
      'new_user_signed_up'
    end

    def sms_content
      "#{payload} signed up: #{Rails.application.routes.url_helpers.user_url(payload)}"
    end
  end
end

module Notifications
  class TwilioErrorThresholdPassedNotification < ::NotificationType
    def mailer_message
      'Twilio Error Threshold has been passed. Check twilio logs for more details'
    end
  end
end

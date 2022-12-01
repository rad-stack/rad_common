module Notifications
  class TwilioErrorThresholdPassedNotification < ::NotificationType
    def mailer_message
      "Twilio Error Threshold has been passed. #{payload * 100}% of messages have failed to deliver. " \
        'Check twilio logs for more details'
    end

    def subject_record
      nil
    end
  end
end

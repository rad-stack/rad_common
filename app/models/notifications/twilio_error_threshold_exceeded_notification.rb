module Notifications
  class TwilioErrorThresholdExceededNotification < ::NotificationType
    def mailer_message
      "Twilio Error Threshold has been exceeded. #{formatted_percent} of messages have failed to deliver. " \
        'Check contact logs for more details'
    end

    def subject_record
      nil
    end

    private

      def formatted_percent
        ActiveSupport::NumberHelper.number_to_percentage(payload * 100, strip_insignificant_zeros: true, precision: 2)
      end
  end
end

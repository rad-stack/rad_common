module RadCommon
  class TwilioErrorThresholdChecker
    FAILURE_THRESHOLD_PERCENTAGE = 0.01

    def check_threshold
      return unless passed_error_threshold?

      check_notification_type
      Notifications::TwilioErrorThresholdPassedNotification.main.notify! failed_percentage
    end

    private

      def failed_percentage
        (recent_undelivered_count / recent_count)
      end

      def passed_error_threshold?
        return false if recent_undelivered_count.zero?

        failed_percentage >= FAILURE_THRESHOLD_PERCENTAGE
      end

      def recent_undelivered_count
        TwilioLog.failure.last_day.count.to_f
      end

      def recent_count
        TwilioLog.last_day.count.to_f
      end

      def check_notification_type
        return if NotificationType.find_by(type: 'Notifications::TwilioErrorThresholdPassedNotification').present?

        Notifications::TwilioErrorThresholdPassedNotification.create! security_roles: [SecurityRole.admin_role]
      end
  end
end

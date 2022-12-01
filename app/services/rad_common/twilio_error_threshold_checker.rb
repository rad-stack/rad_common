module RadCommon
  class TwilioErrorThresholdChecker
    FAILURE_THRESHOLD_PERCENTAGE = 0.05

    def check_threshold
      Notifications::TwilioErrorThresholdPassedNotification.main.notify! if passed_error_threshold?
    end

    private

      def recent_count
        TwilioLog.last_day.count.to_f
      end

      def failed_percentage
        (recent_undelivered_count / recent_count)
      end

      def passed_error_threshold?
        return false if recent_undelivered_count.zero?

        failed_percentage >= FAILURE_THRESHOLD_PERCENTAGE
      end

      def recent_undelivered_count
        TwilioLog.unsuccessful.last_day.count.to_f
      end
  end
end

module RadCommon
  class TwilioErrorThresholdChecker
    FAILURE_THRESHOLD_PERCENTAGE = 0.2
    MIN_FAILURES = 10

    def check_threshold
      return unless exceeded_error_threshold?

      Notifications::TwilioErrorThresholdExceededNotification.main(failed_percentage).notify!
    end

    private

      def failed_percentage
        (recent_undelivered_count / recent_count)
      end

      def exceeded_error_threshold?
        return false if recent_undelivered_count.zero?

        return failed_percentage >= FAILURE_THRESHOLD_PERCENTAGE if recent_undelivered_count >= MIN_FAILURES

        failed_percentage.to_d == 1.0.to_d
      end

      def recent_undelivered_count
        TwilioLog.failure.last_day.count.to_f
      end

      def recent_count
        TwilioLog.last_day.count.to_f
      end
  end
end

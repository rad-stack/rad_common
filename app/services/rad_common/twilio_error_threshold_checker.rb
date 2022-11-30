module RadCommon
  class TwilioErrorThresholdChecker
    FAILURE_THRESHOLD_PERCENTAGE = 0.05

    def self.passed_error_threshold?
      return false if recent_undelivered_count.zero?

      failed_percentage = (recent_undelivered_count / recent_count)
      failed_percentage >= FAILURE_THRESHOLD_PERCENTAGE
    end

    def self.recent_count
      TwilioLog.last_day.count.to_f
    end

    def self.recent_undelivered_count
      TwilioLog.unsuccessful.last_day.count.to_f
    end
  end
end

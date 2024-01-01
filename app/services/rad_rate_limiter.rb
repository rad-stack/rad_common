class RadRateLimiter
  class RateLimitExceededError < StandardError; end

  def initialize(limit:, period:, key:)
    @limit = limit
    @period = period
    @key = key
  end

  def run
    check_rate_limit!

    yield
  end

  private

    def check_rate_limit!
      current_count = increment_key

      raise RateLimitExceededError, "Rate limit exceeded for key: #{@key}" if current_count > @limit
    end

    def increment_key
      cache_key = "rate_limit:#{@key}"
      current_value = Rails.cache.fetch(cache_key, expires_in: @period.minutes) { 0 }
      incremented_value = current_value + 1
      Rails.cache.write(cache_key, incremented_value)
      incremented_value
    end
end

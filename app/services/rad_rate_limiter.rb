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
      raise RateLimitExceededError, "Rate limit exceeded for key: #{@key}" if current_count > @limit
    end

    def current_count
      Rails.cache.fetch(cache_key, expires_in: @period, raw: true) { 0 }
      Rails.cache.increment(cache_key)
    end

    def cache_key
      "rate_limit:#{@key}"
    end
end

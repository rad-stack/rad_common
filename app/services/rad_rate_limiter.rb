class RadRateLimiter
  class RateLimitExceededError < StandardError; end

  attr_reader :limit, :period, :key

  def initialize(limit:, period:, key:)
    @limit = limit
    @period = period
    @key = key
  end

  def self.redis_client
    @redis_client ||= RedisClient.new
  end

  def run
    current_count = increment_key
    set_expiration if current_count == 1

    raise RateLimitExceededError, "Rate limit exceeded for key: #{key}" if current_count > limit

    yield
  end

  private

    def increment_key
      self.class.redis_client.call('INCR', "rate_limit:#{key}")
    end

    def set_expiration
      self.class.redis_client.call('EXPIRE', "rate_limit:#{key}", period)
    end
end

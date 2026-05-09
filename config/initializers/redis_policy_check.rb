unless Rails.env.local?
  Rails.application.config.after_initialize do
    redis_url = ENV.fetch('REDIS_URL', nil)
    next if redis_url.blank?

    redis = Redis.new(url: redis_url, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
    policy = redis.info('memory')['maxmemory_policy']

    unless policy == 'volatile-lru'
      message = "Redis maxmemory_policy is '#{policy}', expected 'volatile-lru'. " \
                'Run: heroku redis:maxmemory --policy volatile-lru -a <app>'

      Sentry.capture_message(message, level: 'warning', tags: { component: 'redis_policy_check' }) if defined?(Sentry)
    end
  end
end

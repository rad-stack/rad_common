if Rails.env.production?
  url = "#{ENV.fetch('REDIS_URL')}/#{ENV.fetch('REDIS_DB')}"

  Sidekiq.configure_server do |config|
    config.redis = { url: url, network_timeout: 5 }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url, network_timeout: 5 }
  end
end

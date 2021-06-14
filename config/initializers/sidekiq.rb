if Rails.env.production? || Rails.env.staging?
  url = "#{ENV.fetch('REDIS_URL')}/#{ENV.fetch('REDIS_DB')}"

  Sidekiq.configure_server do |config|
    config.redis = { url: url, network_timeout: 10 }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url, network_timeout: 10 }
  end
end

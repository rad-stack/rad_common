if Rails.env.production? || Rails.env.staging?
  url = "#{ENV.fetch('REDIS_URL')}/#{ENV.fetch('REDIS_DB', 0)}"

  Sidekiq.configure_server do |config|
    config.redis = { url: url, network_timeout: 10, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url, network_timeout: 10, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end
end

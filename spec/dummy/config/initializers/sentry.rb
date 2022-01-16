Sentry.init do |config|
  config.send_default_pii = !RadicalConfig.secure_sentry?
end

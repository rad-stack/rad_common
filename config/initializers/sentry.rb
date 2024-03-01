Sentry.init do |config|
  config.send_default_pii = !RadConfig.secure_sentry?
end

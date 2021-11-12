Sentry.init do |config|
  config.send_default_pii = !Rails.configuration.rad_common.secure_sentry
end

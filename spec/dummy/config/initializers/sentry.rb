Sentry.init do |config|
  # only enable one or the other of these 2 options

  # enable this for high security systems
  # config.send_default_pii = false

  # enable this for normal security systems
  config.send_default_pii = true
end

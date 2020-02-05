require 'raven'
require 'rad_common/sentry_remove_parameters'

Raven.configure do |config|
  # only enable one or the other of these 2 options

  # enable this for high security systems
  # config.processors << RadCommon::SentryRemoveParameters

  # enable this for normal security systems
  config.processors -= [Raven::Processor::PostData]
end

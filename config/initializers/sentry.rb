Sentry.init do |config|
  config.send_default_pii = !RadConfig.secure_sentry?

  config.excluded_exceptions -= ['ActiveRecord::RecordNotFound']
  config.before_send = lambda do |event, hint|
    event unless hint[:exception].is_a?(ActiveRecord::RecordNotFound) && event.tags[:job_id].blank?
  end
end

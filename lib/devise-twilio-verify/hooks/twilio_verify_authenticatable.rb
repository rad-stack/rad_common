Warden::Manager.after_authentication do |user, auth, options|
  if user.respond_to?(:with_twilio_verify_authentication?)
    twilio_verify = user.with_twilio_verify_authentication?(auth.request)
    auth.session(options[:scope])[:with_twilio_verify_authentication] = twilio_verify
    auth.session(options[:scope])[:id] = user.id if auth.session(options[:scope])[:with_twilio_verify_authentication]
  end
end

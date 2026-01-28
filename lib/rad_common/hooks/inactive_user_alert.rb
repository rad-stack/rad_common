Warden::Manager.before_failure do |env, opts|
  if opts[:scope] == :user && opts[:action] == 'unauthenticated'
    email = env['action_dispatch.request.request_parameters'].dig('user', 'email')

    if email.present?
      user = User.find_by(email: email.downcase.strip)

      if user&.needs_reactivate?
        Notifications::InactiveUserAlertNotification.main(user: user, method_name: 'sign_in_attempt').notify!
      end
    end
  end
end

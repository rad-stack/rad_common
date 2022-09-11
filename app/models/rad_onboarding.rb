class RadOnboarding
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def onboarded?
    @onboarded ||= current_user.admin? || !steps_remaining?
  end

  def onboarding_path
    "/user_profiles/#{current_user.id}"
  end

  def onboarded_path
    raise 'implement in sub class'
  end

  def nav_link
    { name: 'My Profile', path: onboarding_path }
  end

  def edit_profile_title(view_context)
    return view_context.safe_join(['Editing ', view_context.link_to('My Profile', onboarding_path)]) if onboarded?

    'Please Enter Your Profile'
  end

  def steps_remaining?
    !current_user.profile_entered? || next_step.present?
  end

  def next_step
    raise 'implement in sub class'
  end
end

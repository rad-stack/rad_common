class RadOnboarding
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def onboarded?
    @onboarded ||= current_user.admin? || !steps_remaining?
  end

  def onboarding_path
    @onboarding.next_step.path
  end

  def onboarded_path
    raise 'implement in sub class'
  end

  def steps_remaining?
    !current_user.profile_entered? || next_step.present?
  end

  def next_step
    raise 'implement in sub class'
  end
end

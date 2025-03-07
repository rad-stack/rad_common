class Onboarding < RadOnboarding
  def onboarded_path
    '/attorneys'
  end

  def next_step
    return if current_user.profile_entered?

    OnboardingNextStep.new(label: 'Setup Your Profile', path: "/user_profiles/#{current_user.id}/edit")
  end
end

class OnboardingsController < ApplicationController
  before_action :set_onboarding

  def index
    skip_authorization
    skip_policy_scope

    if @onboarding.onboarded?
      redirect_to @onboarding.onboarded_path
    else
      redirect_to @onboarding.onboarding_path(current_user)
    end
  end

  private

    def set_onboarding
      @onboarding = Onboarding.new(current_user)
    end
end

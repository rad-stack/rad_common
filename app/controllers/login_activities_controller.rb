class LoginActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize LoginActivity
    @login_activities = policy_scope(LoginActivity.recent_first).page(params[:page])
  end
end

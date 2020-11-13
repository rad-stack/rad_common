class LoginActivitiesController < ApplicationController
  def index
    authorize LoginActivity
    @login_activity_search = LoginActivitySearch.new(params, current_user)
    @login_activities = policy_scope(@login_activity_search.results).page(params[:page])
  end
end

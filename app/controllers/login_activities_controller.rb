class LoginActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize LoginActivity
    @login_activity_search = LoginActivitySearch.new(params, current_user)
    @login_activities = policy_scope(@login_activity_search.results).page(params[:page])
  end

  # private
  #
  # def permitted_params
  #   params.require(:login_activity).permit(:ip, :agent)
  # end
end

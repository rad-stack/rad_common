class SystemUsagesController < ApplicationController
  def index
    authorize SystemUsage, :index?
    skip_policy_scope

    @system_usage = SystemUsage.new(permitted_params, current_user)
  end

  private

    def permitted_params
      params.permit(:date_mode, :date_range_count)
    end
end

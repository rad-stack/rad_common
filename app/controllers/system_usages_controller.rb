class SystemUsagesController < ApplicationController
  def index
    authorize :system_usage, :index?
    skip_policy_scope

    @system_usage_search = SystemUsageSearch.new(permitted_params, current_user)
  end

  private

    def permitted_params
      params.permit(search: %i[date_mode date_range_count])
    end
end

class SystemUsagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @company = Company.main
    authorize @company, :update?
    skip_policy_scope

    @mode = params[:mode].presence || 'monthly'
    @usage_headers, @usage_items, @usage_data = @company.usage_stats(@mode)
  end
end

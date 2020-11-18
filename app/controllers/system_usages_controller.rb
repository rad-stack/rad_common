class SystemUsagesController < ApplicationController
  def index
    authorize SystemUsage.new, :index?
    skip_policy_scope

    @mode = params[:mode].presence || 'monthly'
    @usage_headers, @usage_items, @usage_data = SystemUsage.usage_stats(@mode)
  end
end

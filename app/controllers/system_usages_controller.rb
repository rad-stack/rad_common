class SystemUsagesController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for Company
  authority_actions index: 'update'

  def index
    @company = Company.main
    @usage_headers, @usage_items, @usage_data = @company.usage_stats
  end
end

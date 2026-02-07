class ApiLogsController < ApplicationController
  before_action :set_api_log, only: :show

  def index
    authorize ApiLog

    @api_log_search = ApiLogSearch.new(params, current_user)
    @api_logs = policy_scope(@api_log_search.results).page(params[:page])
  end

  def show; end

  private

    def set_api_log
      @api_log = ApiLog.find(params[:id])
      authorize @api_log
    end
end

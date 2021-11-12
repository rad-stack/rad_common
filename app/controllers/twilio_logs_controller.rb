class TwilioLogsController < ApplicationController
  def index
    authorize TwilioLog

    @twilio_log_search = TwilioLogSearch.new(params, current_user)
    @twilio_logs = policy_scope(@twilio_log_search.results).page(params[:page])
  end
end

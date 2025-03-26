class ContactLogsController < ApplicationController
  def index
    authorize ContactLog

    @twilio_log_search = ContactLogSearch.new(params, current_user)
    @twilio_logs = policy_scope(@twilio_log_search.results).page(params[:page])
  end
end

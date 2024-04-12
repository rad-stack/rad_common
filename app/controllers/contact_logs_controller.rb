class ContactLogsController < ApplicationController
  def index
    authorize ContactLog

    @contact_log_search = ContactLogSearch.new(params, current_user)
    @contact_logs = policy_scope(@contact_log_search.results).page(params[:page])
  end
end

class ContactLogsController < ApplicationController
  before_action :set_contact_log, only: :show

  def index
    authorize ContactLog

    @contact_log_search = ContactLogSearch.new(params, current_user)
    @contact_logs = policy_scope(@contact_log_search.results).page(params[:page])
  end

  def show
    @contact_log_recipients = @contact_log.contact_log_recipients.sorted
  end

  def related_to
    authorize ContactLog

    @contact_log_search = ContactLogSearch.new(params,
                                               current_user,
                                               related_to_type: params[:related_to_type],
                                               related_to_id: params[:related_to_id])

    @contact_logs = policy_scope(@contact_log_search.results).page(params[:page])

    render :index
  end

  private

    def set_contact_log
      @contact_log = ContactLog.find(params[:id])
      authorize @contact_log
    end
end

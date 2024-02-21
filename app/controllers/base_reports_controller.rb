class BaseReportsController < ApplicationController
  def index
    authorize_report
    skip_policy_scope

    set_report

    if @report.valid?
      flash[:warning] = @report.warning_message
    else
      flash.now[:error] = @report.error_message
      return
    end

    respond_to do |format|
      format.html
      format.pdf { print_report }
      format.csv do
        export_job.perform_later(params.to_unsafe_hash, current_user.id, format: :csv)
        flash[:success] = report_generating_message
        redirect_back fallback_location: :index
      end
    end
  end

  private

    def print_report
      render pdf: @report.title.parameterize.underscore, orientation: @report.orientation
    end

    def authorize_report
      raise 'Must implement #authorize_report in sub class'
    end

    def set_report
      raise 'Must implement #set_report in sub class'
    end

    def export_job
      @report.export_job.presence || raise('Must implement #export_job in sub class to support CSV Export')
    end

    def pdf_output?
      request.format.pdf?
    end
end

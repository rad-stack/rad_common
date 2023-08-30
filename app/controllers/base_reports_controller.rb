class BaseReportsController < ApplicationController
  def index
    authorize_report
    skip_policy_scope

    set_report

    if @report.valid?
      flash[:warning] = @report.warning
    else
      flash.now[:error] = @report.errors
      return
    end

    respond_to do |format|
      format.html
      format.pdf { print_report }
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

    def pdf_output?
      request.format.pdf?
    end
end

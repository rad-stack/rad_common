module Exportable
  extend ActiveSupport::Concern

  def export
    authorize export_resource

    respond_to do |format|
      format.any(:csv, :pdf) do
        export_job.perform_later(export_job_params, current_user.id, format: request.format.symbol)
      end
    end

    flash[:notice] = report_generating_message
    export_redirect
  end

  private

    def export_resource
      return @custom_report if defined?(@custom_report) && @custom_report.present?

      export_resource_class
    end

    def export_resource_class
      controller_name.classify.constantize
    rescue NameError
      raise 'Export Resource Class could not be determined from controller name, must override export_resource_class'
    end

    def export_job
      return CustomReportExporterJob if defined?(@custom_report) && @custom_report.present?

      "#{export_resource_class}ExportJob".constantize
    end

    def export_job_params
      if defined?(@custom_report) && @custom_report.present?
        safe_params = params&.permit! || ActionController::Parameters.new
        safe_params.to_h.merge(custom_report_id: @custom_report.id)
      else
        respond_to?(:search_params) ? search_params.to_h : {}
      end
    end

    def export_redirect
      return redirect_to(params[:redirect_to]) if params[:redirect_to].present?

      if defined?(@custom_report) && @custom_report.present?
        redirect_to @custom_report, params: report_redirect_params
      else
        redirect_to action: :index, params: (respond_to?(:search_params) ? search_params.to_h : {})
      end
    end

    def report_redirect_params
      safe_params = params&.except(:format, :commit, :action, :controller, :custom_report_id) || ActionController::Parameters.new
      safe_params.permit!.to_h
    end
end

module Exportable
  extend ActiveSupport::Concern

  def export
    authorize export_resource_class

    respond_to do |format|
      format.any(:csv, :pdf) do
        export_job.perform_later(search_params.to_h, current_user.id, format: request.format.symbol)
      end
    end

    flash[:success] = report_generating_message
    export_redirect
  end

  private

    def export_resource_class
      controller_name.classify.constantize
    rescue NameError
      raise 'Export Resource Class could not be determined from controller name, must override export_resource_class'
    end

    def export_job
      "#{export_resource_class}ExportJob".constantize
    end

    def export_redirect
      return redirect_to(params[:redirect_to]) if params[:redirect_to].present?

      redirect_to action: :index, params: search_params.to_h
    end
end

class CustomReportFiltersController < ApplicationController
  include CustomReportsHelper

  before_action :set_custom_report
  before_action :set_context_data

  def new
    authorize CustomReportFilter

    @custom_report_filter = CustomReportFilter.new(
      report_model: @custom_report.report_model,
      joins: @joins
    )

    respond_to do |format|
      format.html do
        render partial: 'custom_report_filters/form',
               locals: { custom_report_filter: @custom_report_filter,
                         all_columns: @all_columns,
                         filter_types_map: @filter_types_map }
      end
    end
  end

  def create
    authorize CustomReportFilter

    @custom_report_filter = CustomReportFilter.new(
      custom_report_filter_params.merge(
        report_model: @custom_report.report_model,
        joins: @joins
      )
    )

    respond_to do |format|
      if @custom_report_filter.valid?
        filter_config = @custom_report_filter.to_filter_config
        filter_row = build_filter_row(filter_config)

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('filters-list',
                                partial: 'custom_report_filters/filter_row',
                                locals: { filter: filter_row }),
            turbo_stream.action(:hide_modal, 'custom-report-filter-modal')
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'custom-report-filter-form-frame',
            partial: 'custom_report_filters/form',
            locals: { custom_report_filter: @custom_report_filter,
                      all_columns: @all_columns,
                      filter_types_map: @filter_types_map }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  private

    def set_custom_report
      if params[:custom_report_id].present?
        @custom_report = CustomReport.find(params[:custom_report_id])
      else
        @custom_report = CustomReport.new
        @custom_report.report_model = params[:report_model] if params[:report_model].present?
      end
      authorize @custom_report
    end

    def set_context_data
      @joins = Array(params[:joins]).reject(&:blank?)
      @all_columns = if @custom_report.report_model.present?
                       model_columns(@custom_report.report_model, @joins)
                     else
                       []
                     end
      @filter_types_map = filter_types_map
    end

    def custom_report_filter_params
      params.require(:custom_report_filter).permit(:column, :type, :label)
    end

    def build_filter_row(filter_config)
      {
        column: filter_config['column'],
        type: filter_config['type'],
        label: filter_config['label']
      }
    end
end

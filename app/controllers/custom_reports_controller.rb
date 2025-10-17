class CustomReportsController < ApplicationController
  include CustomReportsHelper
  include Exportable

  before_action :set_custom_report, only: %i[show edit update destroy]
  before_action :build_temp_report, only: %i[update_joins update_filters]

  def index
    authorize CustomReport
    @custom_reports = policy_scope(CustomReport.active.by_name)
  end

  def show
    @report = RadReports::Report.new(
      custom_report: @custom_report,
      current_user: current_user,
      params: params
    )

    authorize :custom_report, :show?

    @results = @report.results.page(params[:page]).per(@report.page_size_param)

    respond_to do |format|
      format.html
      format.any(:csv, :pdf) { export }
    end
  end

  def new
    @custom_report = CustomReport.new
    authorize @custom_report
    @custom_report.report_model = params[:report_model] if params[:report_model].present?

    return if params[:joins].blank?

    config = @custom_report.configuration || {}
    config['joins'] = params[:joins].reject(&:blank?)
    @custom_report.configuration = config
  end

  def edit
    authorize @custom_report

    return if params[:joins].blank?

    config = @custom_report.configuration || {}
    config['joins'] = params[:joins].reject(&:blank?)
    @custom_report.configuration = config
  end

  def create
    @custom_report = CustomReport.new(custom_report_params)
    authorize @custom_report

    if @custom_report.save
      redirect_to custom_report_path(@custom_report), notice: 'Custom report created successfully.'
    else
      render :new
    end
  end

  def update
    authorize @custom_report

    if @custom_report.update(custom_report_params)
      redirect_to custom_report_path(@custom_report), notice: 'Custom report updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    authorize @custom_report

    if @custom_report.destroy
      redirect_to custom_reports_path, notice: 'Custom report deleted successfully.'
    else
      redirect_to custom_reports_path, alert: 'Could not delete custom report.'
    end
  end

  def update_joins
    authorize @custom_report

    joins = params[:joins] || []
    joins = (joins + [params[:add_join]]).uniq if params[:add_join].present?
    joins -= [params[:remove_join]] if params[:remove_join].present?

    config = @custom_report.configuration || {}
    config['joins'] = joins.reject(&:blank?)
    @custom_report.configuration = config

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update_filters
    authorize @custom_report

    @filter_index = params[:filter_count].to_i
    @filter = { 'column' => '', 'label' => '', 'type' => '' }
    @joins = params[:joins] || []
    @all_columns = model_columns(@custom_report.report_model, @joins)
    @report_model = @custom_report.report_model
    @report_id = @custom_report.persisted? ? @custom_report.id : nil

    respond_to do |format|
      if request.post?
        format.turbo_stream
      elsif request.delete?
        format.turbo_stream
      end
    end
  end

  private

    def set_custom_report
      @custom_report = CustomReport.find(params[:id])
    end

    def build_temp_report
      if params[:id].present?
        @custom_report = CustomReport.find(params[:id])
      else
        @custom_report = CustomReport.new
        @custom_report.report_model = params[:report_model] if params[:report_model].present?
      end

      authorize @custom_report
    end

    def custom_report_params
      permitted = params.require(:custom_report).permit(
        :name,
        :description,
        :report_model,
        :active,
        columns: %i[name label select format],
        filters: %i[column label type options],
        sort_columns: %i[label column],
        joins: []
      )

      build_configuration(permitted) if configuration_params_present?(permitted)

      permitted
    end

    def configuration_params_present?(permitted)
      permitted[:columns] || permitted[:filters] || permitted[:sort_columns] || permitted[:joins]
    end

    def build_configuration(permitted)
      configuration = {}
      configuration['columns'] = extract_config_array(permitted.delete(:columns)) if permitted[:columns]
      configuration['filters'] = extract_config_array(permitted.delete(:filters)) if permitted[:filters]
      configuration['sort_columns'] = extract_config_array(permitted.delete(:sort_columns)) if permitted[:sort_columns]
      configuration['joins'] = permitted.delete(:joins).reject(&:blank?) if permitted[:joins]
      permitted[:configuration] = configuration
    end

    def extract_config_array(params)
      return [] unless params

      if params.is_a?(ActionController::Parameters)
        params.values.map(&:to_h)
      elsif params.is_a?(Array)
        params.map(&:to_h)
      else
        []
      end
    end
end

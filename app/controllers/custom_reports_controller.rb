class CustomReportsController < ApplicationController
  include CustomReportsHelper
  include Exportable

  before_action :set_custom_report, only: %i[show edit update destroy]
  before_action :build_temp_report, only: %i[update_joins update_filters]

  def index
    authorize CustomReport
    @custom_reports = policy_scope(CustomReport.by_name).page(params[:page])
  end

  def show
    @report = RadReports::Report.new(custom_report: @custom_report, current_user: current_user, params: params)
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
    config['joins'] = RadReports::ConfigurationBuilder.sanitize_joins(params[:joins])
    @custom_report.configuration = config
  end

  def edit
    authorize @custom_report

    return if params[:joins].blank?

    config = @custom_report.configuration || {}
    config['joins'] = RadReports::ConfigurationBuilder.sanitize_joins(params[:joins])
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

    if params[:remove_join].present?
      removed_join = params[:remove_join]
      joins = joins.reject { |j| j == removed_join || j.start_with?("#{removed_join}.") }
    end

    joins = expand_nested_joins(joins)

    config = @custom_report.configuration || {}
    config['joins'] = RadReports::ConfigurationBuilder.sanitize_joins(joins)
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
      format.turbo_stream
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
        columns: %i[name label select formula],
        filters: %i[column label type options data_type],
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
      config_params = {
        columns: permitted.delete(:columns),
        filters: permitted.delete(:filters),
        sort_columns: permitted.delete(:sort_columns),
        joins: permitted.delete(:joins)
      }.compact

      permitted[:configuration] = RadReports::ConfigurationBuilder.build(config_params)
    end

    def expand_nested_joins(joins)
      expanded = []
      joins.each do |join_path|
        parts = join_path.split('.')
        parts.each_with_index do |_part, index|
          expanded << parts[0..index].join('.')
        end
      end
      expanded.uniq
    end
end

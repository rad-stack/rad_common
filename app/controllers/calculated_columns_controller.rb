class CalculatedColumnsController < ApplicationController
  include CustomReportsHelper

  before_action :set_custom_report
  before_action :set_context_data

  def new
    authorize CalculatedColumn

    @calculated_column = CalculatedColumn.new(
      report_model: @custom_report.report_model,
      joins: @joins
    )

    respond_to do |format|
      format.html do
        render partial: 'calculated_columns/form',
               locals: { presenter: build_presenter(editing: false) }
      end
    end
  end

  def edit
    authorize CalculatedColumn

    column_config = find_column_config_by_name(params[:id])
    @calculated_column = CalculatedColumn.from_column_config(
      column_config,
      report_model: @custom_report.report_model,
      joins: @joins
    )

    respond_to do |format|
      format.html do
        render partial: 'calculated_columns/form',
               locals: { presenter: build_presenter(editing: true, row_id: params[:row_id]) }
      end
    end
  end

  def create
    authorize CalculatedColumn

    @calculated_column = CalculatedColumn.new(
      calculated_column_params.merge(
        report_model: @custom_report.report_model,
        joins: @joins
      )
    )

    respond_to do |format|
      if @calculated_column.valid?
        format.turbo_stream do
          render turbo_stream: create_success
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'calculated-column-form-frame',
            partial: 'calculated_columns/form',
            locals: { presenter: build_presenter(editing: false) }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  def update
    authorize CalculatedColumn

    @calculated_column = CalculatedColumn.new(
      calculated_column_params.merge(
        report_model: @custom_report.report_model,
        joins: @joins
      )
    )

    respond_to do |format|
      if @calculated_column.valid?
        format.turbo_stream do
          render turbo_stream: update_success
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'calculated-column-form-frame',
            partial: 'calculated_columns/form',
            locals: { presenter: build_presenter(editing: true, row_id: params[:row_id]) }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  private

    def create_success
      column_config = @calculated_column.to_column_config
      calculated_column_row = build_calculated_column_row(column_config)
      [turbo_stream.append('selected-columns-list',
                           partial: 'custom_reports/selected_column_row',
                           locals: { column: calculated_column_row,
                                     table_id: 'calculated',
                                     formula: column_config['formula'] }),
       turbo_stream.action(:hide_modal, 'calculated-column-modal')]
    end

    def update_success
      column_config = @calculated_column.to_column_config
      calculated_column_row = build_calculated_column_row(column_config)
      row_id = params[:row_id]

      [turbo_stream.replace(row_id,
                            partial: 'custom_reports/selected_column_row',
                            locals: { column: calculated_column_row,
                                      table_id: 'calculated',
                                      formula: column_config['formula'] }),
       turbo_stream.action(:hide_modal, 'calculated-column-modal')]
    end

    def find_column_config_by_name(name)
      return {} unless @custom_report.persisted?

      (@custom_report.columns || []).find { |col| col['name'] == name } || {}
    end

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
      @columns_by_table = if @custom_report.report_model.present?
                            model_columns_by_table(@custom_report.report_model, @joins)
                          else
                            []
                          end
    end

    def build_presenter(editing:, row_id: nil)
      CalculatedColumnFormPresenter.new(
        view_context,
        calculated_column: @calculated_column,
        columns_by_table: @columns_by_table,
        editing: editing,
        row_id: row_id
      )
    end

    def calculated_column_params
      params.require(:calculated_column).permit(:name, :label, :formula_type, formula_params: {})
    end

    def build_calculated_column_row(column_config)
      {
        name: column_config['name'],
        type: 'calculated',
        table: 'calculated',
        association: nil,
        custom_label: column_config['label'],
        sortable: false,
        is_calculated: true
      }
    end
end

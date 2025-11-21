class CalculatedColumnFormPresenter
  include CustomReportsHelper

  attr_reader :view, :calculated_column, :columns_by_table, :editing, :row_id

  delegate :params, :calculated_column_path, :calculated_columns_path,
           :grouped_options_for_select, :options_for_select, :content_tag,
           :safe_join, :label_tag, :select_tag, :number_field_tag, :text_field_tag,
           to: :view

  def initialize(view_context, calculated_column:, columns_by_table:, editing: false, row_id: nil)
    @view = view_context
    @calculated_column = calculated_column
    @columns_by_table = columns_by_table
    @editing = editing
    @row_id = row_id
  end

  def form_url
    if editing
      calculated_column_path(calculated_column.name, form_url_params.merge(row_id: row_id))
    else
      calculated_columns_path(form_url_params)
    end
  end

  def form_method
    editing ? :patch : :post
  end

  def modal_title
    editing ? 'Edit Calculated Column' : 'Create Calculated Column'
  end

  def submit_button_icon
    editing ? 'fa-check' : 'fa-plus'
  end

  def submit_button_text
    editing ? 'Update Column' : 'Add Column'
  end

  def column_groups
    @column_groups ||= calculated_column_groups(columns_by_table)
  end

  def calculated_formulas
    @calculated_formulas ||= RadReports::FormulaRegistry.calculated_formulas
  end

  def formula_options
    @formula_options ||= RadReports::FormulaRegistry.calculated_grouped_options
  end

  def columns_unavailable?
    column_groups.blank?
  end

  def formula_params_class(type)
    calculated_column_class(calculated_column, type)
  end

  def build_param_field(param, type)
    ParamFieldBuilder.new(self, param, type)
  end

  private

    def form_url_params
      {
        custom_report_id: params[:custom_report_id] || params[:id],
        report_model: calculated_column.report_model,
        joins: params[:joins] || calculated_column.joins
      }
    end

  class ParamFieldBuilder
    attr_reader :presenter, :param, :type

    delegate :calculated_column, :column_groups, :columns_unavailable?,
             :grouped_options_for_select, :options_for_select, :content_tag,
             :safe_join, :label_tag, :select_tag, :number_field_tag, :text_field_tag,
             to: :presenter

    def initialize(presenter, param, type)
      @presenter = presenter
      @param = param
      @type = type
    end

    def column_class
      param[:col_class] || 'col-12'
    end

    def field_name
      multiple? ? "#{field_base}[]" : field_base
    end

    def input_id
      "calculated-column-#{type.parameterize}-#{param[:name]}"
    end

    def value
      calculated_column.param_value(param)
    end

    def label
      param[:label]
    end

    def field_type
      param[:type]
    end

    def multiple?
      param[:type] == 'column_selector' && param[:name].to_s == 'columns'
    end

    def placeholder
      param[:placeholder]
    end

    def step
      param[:step] || 'any'
    end

    def select_options
      param[:options]
    end

    def column_selector_options_html
      base_options = column_groups.present? ? grouped_options_for_select(column_groups, value) : ''
      return base_options if multiple?

      safe_join([content_tag(:option, 'Select a column', value: ''), base_options])
    end

    def column_selector_html_options
      options = {
        class: 'form-select',
        id: input_id,
        disabled: columns_unavailable?,
        data: { calculated_column_form_target: 'columnSelector' }
      }
      options[:multiple] = true if multiple?
      options
    end

    private

      def field_base
        "calculated_column[formula_params][#{param[:name]}]"
      end
  end
end

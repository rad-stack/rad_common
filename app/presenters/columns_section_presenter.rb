class ColumnsSectionPresenter
  include CustomReportsHelper

  attr_reader :view, :custom_report

  delegate :new_calculated_column_path, :render, to: :view

  def initialize(view_context, custom_report)
    @view = view_context
    @custom_report = custom_report
  end

  def config
    @config ||= custom_report.configuration || {}
  end

  def joins
    @joins ||= custom_report.joins || []
  end

  def columns
    @columns ||= custom_report.columns || []
  end

  def all_columns
    @all_columns ||= model_columns(custom_report.report_model, joins)
  end

  def columns_by_table
    @columns_by_table ||= model_columns_by_table(custom_report.report_model, joins)
  end

  def selected_column_keys
    @selected_column_keys ||= columns.map { |c| c['select'] }
  end

  def calculated_column_url
    @calculated_column_url ||= new_calculated_column_path(
      report_model: custom_report.report_model,
      joins: joins,
      custom_report_id: custom_report.persisted? ? custom_report.id : nil
    )
  end

  def selected_columns_config
    @selected_columns_config ||= config['columns'] || []
  end

  # Table section helpers
  def table_id_for(table_info)
    table_id_base = table_info[:association] || table_info[:table]
    "table-#{table_id_base.gsub('.', '-').gsub('_', '-')}"
  end

  def base_table?(table_info)
    table_info[:association].nil?
  end

  def table_button_classes(table_info)
    classes = 'list-group-item list-group-item-action py-3 px-3 text-start border-0 fw-medium'
    classes += ' active' if base_table?(table_info)
    classes
  end

  def table_tab_classes(table_info)
    classes = 'tab-pane fade'
    classes += ' show active' if base_table?(table_info)
    classes
  end

  # Selected column builder
  def build_selected_column(col_config)
    if col_config['is_calculated']
      build_calculated_column_data(col_config)
    else
      build_regular_column_data(col_config)
    end
  end

  private

    def build_calculated_column_data(col_config)
      {
        column: {
          name: col_config['name'],
          type: 'calculated',
          table: 'calculated',
          association: nil,
          custom_label: col_config['label'],
          sortable: false,
          is_calculated: true
        },
        table_id: 'calculated',
        formula: col_config['formula']
      }
    end

    def build_regular_column_data(col_config)
      col = find_column_for_config(col_config)
      return nil if col.blank?

      {
        column: col.merge(
          custom_label: col_config['label'],
          sortable: col_config['sortable']
        ),
        table_id: table_id_for_column(col),
        formula: col_config['formula']
      }
    end

    def find_column_for_config(col_config)
      select_parts = col_config['select']&.split('.') || []
      table_or_association = select_parts[0..-2].join('.')
      col_name = col_config['name']

      all_columns.find do |c|
        c[:name] == col_name &&
          (c[:association] == table_or_association ||
           c[:table] == table_or_association ||
           (c[:association].nil? && table_or_association.blank?))
      end
    end

    def table_id_for_column(col)
      table_id_base = col[:association] || col[:table]
      "table-#{table_id_base.gsub('.', '-').gsub('_', '-')}"
    end
end

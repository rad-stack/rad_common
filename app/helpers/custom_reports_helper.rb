module CustomReportsHelper
  delegate :available_models, to: RadReports::ModelDiscovery

  def model_columns(model_name, joins = [])
    RadReports::ColumnDiscovery.new(model_name, joins).all_columns
  end

  def model_columns_by_table(model_name, joins = [])
    RadReports::ColumnDiscovery.new(model_name, joins).columns_by_table
  end

  def available_filter_types
    RadReports::FilterRegistry.all_options
  end

  def available_filter_types_for_column(column_type)
    RadReports::FilterRegistry.options_for_column_type(column_type)
  end

  def filter_types_map
    RadReports::FilterRegistry.column_type_filters
  end

  def model_associations(model_name)
    RadReports::AssociationDiscovery.new(model_name).model_associations
  end

  def available_associations_with_details(model_name, joins = [])
    RadReports::AssociationDiscovery.new(model_name, joins).available_associations
  end

  # Column helpers for consistent ID and parameter generation
  def column_select_prefix(column)
    column[:association] || column[:table]
  end

  def column_key(column)
    "#{column_select_prefix(column)}.#{column[:name]}"
  end

  def column_id(column, prefix: 'column')
    "#{prefix}-#{column_key(column).gsub('.', '-')}"
  end

  def column_path(column)
    # Special handling for calculated columns
    return "calculated.#{column[:name]}" if column[:is_calculated] || column[:type] == 'calculated'

    if column[:association].present? && column[:association_label] && column[:association_label] != column[:table_label]
      "#{column[:association_label]}.#{column[:name]}"
    elsif column[:table_label]
      "#{column[:table_label]}.#{column[:name]}"
    else
      "#{column[:table]}.#{column[:name]}"
    end
  end

  def column_url_params(column, table_id, column_id)
    {
      column_name: column[:name],
      column_table: column[:table],
      column_type: column[:type],
      column_association: column[:association],
      column_table_label: column[:table_label],
      column_association_label: column[:association_label],
      table_id: table_id,
      column_id: column_id,
      format: :turbo_stream
    }.compact
  end

  def ai_report_builder_button
    button_tag(class: 'btn btn-primary btn-sm',
               'data-bs-target' => '#basic-question-modal',
               'data-bs-toggle' => 'offcanvas') do
      sanitize("#{content_tag(:i, '', class: 'fa fa-magic me-1')} AI Report Builder")
    end
  end

  def grouped_column_options_for_filter(columns)
    grouped_options = {}

    columns.each do |col|
      group_label = col[:association_label].presence || col[:table_label]
      grouped_options[group_label] ||= []

      column_path = col[:association] ? "#{col[:association]}.#{col[:name]}" : "#{col[:table]}.#{col[:name]}"
      option_label = "#{col[:name].humanize} - #{col[:type]}"

      grouped_options[group_label] << [
        option_label,
        column_path,
        {
          'data-column-type' => col[:type],
          'data-is-foreign-key' => col[:is_foreign_key],
          'data-is-enum' => col[:is_enum]
        }
      ]
    end

    grouped_options
  end

  def custom_report_filter_url_params(params)
    {
      custom_report_id: params[:custom_report_id],
      report_model: params[:report_model],
      joins: params[:joins]
    }.compact
  end
end

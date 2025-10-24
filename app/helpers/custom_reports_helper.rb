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
end

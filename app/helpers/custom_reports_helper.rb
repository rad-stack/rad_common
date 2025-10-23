module CustomReportsHelper
  def format_report_value(report, record, select_clause)
    column_def = report.column_definitions.find { |c| c[:select] == select_clause }
    RadReports::ValueFormatter.format_record_value(record, select_clause, column_def)
  end

  delegate :available_models, to: RadReports::ModelDiscovery

  def model_columns(model_name, joins = [])
    RadReports::ColumnDiscovery.new(model_name, joins).all_columns
  end

  def model_columns_by_table(model_name, joins = [])
    RadReports::ColumnDiscovery.new(model_name, joins).columns_by_table
  end

  def available_filter_types
    [
      ['Text Search (LIKE)', 'RadSearch::LikeFilter'],
      ['Exact Match', 'RadSearch::EqualsFilter'],
      ['Date Range', 'RadSearch::DateFilter'],
      ['Boolean', 'RadSearch::BooleanFilter'],
      ['Dropdown', 'RadSearch::SearchFilter'],
      ['Dropdown (Array)', 'RadSearch::ArrayFilter'],
      ['Enum', 'RadSearch::EnumFilter']
    ]
  end

  def available_filter_types_for_column(column_type)
    all_filters = {
      like: ['Text Search (LIKE)', 'RadSearch::LikeFilter'],
      equals: ['Exact Match', 'RadSearch::EqualsFilter'],
      date: ['Date Range', 'RadSearch::DateFilter'],
      boolean: ['Boolean', 'RadSearch::BooleanFilter'],
      array: ['Dropdown (Array)', 'RadSearch::ArrayFilter'],
      dropdown: ['Dropdown', 'RadSearch::SearchFilter']
    }

    case column_type.to_s
    when 'date', 'datetime', 'timestamp'
      [all_filters[:date], all_filters[:equals]]
    when 'boolean'
      [all_filters[:boolean]]
    when 'integer', 'bigint', 'decimal', 'float'
      [all_filters[:equals], all_filters[:dropdown]]
    else
      filters = [all_filters[:like], all_filters[:equals], all_filters[:dropdown]]
      filters << all_filters[:array] if column_type.to_s == 'array'
      filters
    end
  end

  def filter_types_map
    {
      'date' => available_filter_types_for_column('date'),
      'datetime' => available_filter_types_for_column('datetime'),
      'timestamp' => available_filter_types_for_column('timestamp'),
      'boolean' => available_filter_types_for_column('boolean'),
      'integer' => available_filter_types_for_column('integer'),
      'bigint' => available_filter_types_for_column('bigint'),
      'decimal' => available_filter_types_for_column('decimal'),
      'float' => available_filter_types_for_column('float'),
      'string' => available_filter_types_for_column('string'),
      'text' => available_filter_types_for_column('text'),
      'rich_text' => available_filter_types_for_column('text'),
      'attachment' => available_filter_types_for_column('text')
    }
  end

  def available_column_formats
    [
      ['String', 'string'],
      ['Integer', 'integer'],
      ['Decimal', 'decimal'],
      ['Currency', 'currency'],
      ['Date', 'date'],
      ['DateTime', 'datetime'],
      ['Boolean', 'boolean'],
      ['Email', 'email'],
      ['Phone', 'phone'],
      ['Rich Text', 'rich_text'],
      ['Attachment', 'attachment']
    ]
  end

  def model_associations(model_name)
    RadReports::AssociationDiscovery.new(model_name).model_associations
  end

  def available_associations_with_details(model_name, joins = [])
    RadReports::AssociationDiscovery.new(model_name, joins).available_associations
  end
end

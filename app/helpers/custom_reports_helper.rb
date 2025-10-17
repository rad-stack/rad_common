module CustomReportsHelper
  def format_report_value(report, record, select_clause)
    column_def = report.column_definitions.find { |c| c[:select] == select_clause }
    RadReports::ValueFormatter.format_record_value(record, select_clause, column_def)
  end

  def available_models
    # Dynamically discover ApplicationRecord models from the host application
    # Exclude base classes and gem models
    Rails.application.eager_load! unless Rails.application.config.eager_load

    ApplicationRecord.descendants.filter_map do |model|
      # Skip abstract classes
      next if model.abstract_class?

      # Skip anonymous classes
      next if model.name.blank?

      # Skip gem/engine models (they're in modules)
      next if model.name.include?('::') && !model.name.start_with?('ActiveStorage::', 'ActionText::')

      next if model.name.start_with?('ActiveStorage::', 'ActionText::', 'Audited::')

      [model.model_name.human, model.name]
    end.sort_by(&:first)
  end

  def model_columns(model_name, joins = [])
    return [] unless model_name.present?

    klass = model_name.constantize
    all_columns = []

    base_columns = klass.columns.map do |col|
      {
        name: col.name,
        type: col.type,
        table: klass.table_name,
        table_label: klass.model_name.human,
        association: nil,
        association_label: nil
      }
    end
    all_columns.concat(base_columns)

    rich_text_columns = get_rich_text_columns(klass).map do |attr_name|
      {
        name: attr_name,
        type: :rich_text,
        table: klass.table_name,
        table_label: klass.model_name.human,
        association: nil,
        association_label: nil
      }
    end
    all_columns.concat(rich_text_columns)

    # Add columns from joined associations
    joins.each do |join_name|
      association = klass.reflect_on_association(join_name.to_sym)
      next unless association

      associated_class = association.klass
      # Use the association name (e.g., "Owner") as the primary label
      association_label = join_name.to_s.titleize
      class_label = associated_class.model_name.human

      associated_columns = associated_class.columns.map do |col|
        {
          name: col.name,
          type: col.type,
          table: associated_class.table_name,
          table_label: class_label,
          association: join_name,
          association_label: association_label
        }
      end
      all_columns.concat(associated_columns)

      rich_text_columns = get_rich_text_columns(associated_class).map do |attr_name|
        {
          name: attr_name,
          type: :rich_text,
          table: associated_class.table_name,
          table_label: class_label,
          association: join_name,
          association_label: association_label
        }
      end
      all_columns.concat(rich_text_columns)
    end

    all_columns
  rescue StandardError
    []
  end

  def model_columns_by_table(model_name, joins = [])
    columns = model_columns(model_name, joins)
    columns.group_by do |col|
      {
        table: col[:table],
        label: col[:association_label] || col[:table_label],
        class_label: col[:table_label],
        association: col[:association]
      }
    end
  end

  def available_filter_types
    [
      ['Text Search (LIKE)', 'RadSearch::LikeFilter'],
      ['Exact Match', 'RadSearch::EqualsFilter'],
      ['Date Range', 'RadSearch::DateFilter'],
      ['Boolean', 'RadSearch::BooleanFilter'],
      ['Dropdown (Array)', 'RadSearch::ArrayFilter'],
      ['Enum', 'RadSearch::EnumFilter'],
      ['Search', 'RadSearch::SearchFilter']
    ]
  end

  def available_filter_types_for_column(column_type)
    all_filters = {
      like: ['Text Search (LIKE)', 'RadSearch::LikeFilter'],
      equals: ['Exact Match', 'RadSearch::EqualsFilter'],
      date: ['Date Range', 'RadSearch::DateFilter'],
      boolean: ['Boolean', 'RadSearch::BooleanFilter'],
      array: ['Dropdown (Array)', 'RadSearch::ArrayFilter'],
      search: ['Search', 'RadSearch::SearchFilter']
    }

    case column_type.to_s
    when 'date', 'datetime', 'timestamp'
      [all_filters[:date], all_filters[:equals]]
    when 'boolean'
      [all_filters[:boolean], all_filters[:equals]]
    when 'integer', 'bigint', 'decimal', 'float'
      [all_filters[:equals], all_filters[:array]]
    else
      [all_filters[:like], all_filters[:equals], all_filters[:search], all_filters[:array]]
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
      'rich_text' => available_filter_types_for_column('text')
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
      ['Rich Text', 'rich_text']
    ]
  end

  def model_associations(model_name)
    return [] unless model_name.present?

    klass = model_name.constantize

    # Filter associations that are suitable for reporting joins
    klass.reflect_on_all_associations.filter_map do |assoc|
      # Skip polymorphic associations (they can't be simply joined)
      next if assoc.polymorphic?

      # Skip has_many :through for now (could be added later with more complex logic)
      next if assoc.options[:through].present?

      # Get the associated class to show more info
      begin
        associated_class = assoc.klass
        association_type = assoc.macro.to_s.humanize

        next if associated_class.name == 'ActionText::RichText'
        next if associated_class.name == 'Audited::Audit'
        next if assoc.name.to_s.include?('duplicate')

        # Create a descriptive label
        label = "#{assoc.name.to_s.titleize} (#{association_type} #{associated_class.model_name.human})"

        [label, assoc.name.to_s]
      rescue NameError
        # Skip if associated class doesn't exist
        nil
      end
    end
  rescue NameError
    []
  end

  def available_associations_with_details(model_name)
    return [] if model_name.blank?

    klass = model_name.constantize

    klass.reflect_on_all_associations.filter_map do |assoc|
      next if assoc.polymorphic?
      next if assoc.options[:through].present?

      begin
        associated_class = assoc.klass

        next if associated_class.name.in?(['ActionText::RichText', 'Audited::Audit'])
        next if assoc.name.to_s.include?('duplicate')

        {
          name: assoc.name.to_s,
          label: assoc.name.to_s.titleize,
          type: assoc.macro.to_s,
          class_name: associated_class.name,
          table_name: associated_class.table_name,
          foreign_key: assoc.foreign_key
        }
      rescue NameError
        nil
      end
    end
  rescue NameError
    []
  end

  private

    def get_rich_text_columns(klass)
      klass.reflect_on_all_associations.filter_map do |assoc|
        next unless assoc.klass.name == 'ActionText::RichText' && assoc.name.to_s.start_with?('rich_text_')

        assoc.name.to_s.sub('rich_text_', '')
      end
    rescue StandardError
      []
    end


end

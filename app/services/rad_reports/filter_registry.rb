module RadReports
  class FilterRegistry
    FILTERS = {
      'RadSearch::LikeFilter' => {
        label: 'Text Search (LIKE)',
        description: 'Case-insensitive text search',
        compatible_types: %w[string text rich_text attachment],
        options: []
      },
      'RadSearch::EqualsFilter' => {
        label: 'Exact Match',
        description: 'Exact value matching',
        compatible_types: %w[string text rich_text attachment integer bigint decimal float],
        options: []
      },
      'RadSearch::DateFilter' => {
        label: 'Date Range',
        description: 'Date range filtering',
        compatible_types: %w[date datetime timestamp],
        options: [
          { name: 'default_start_value', type: 'date', description: 'Default start date' },
          { name: 'default_end_value', type: 'date', description: 'Default end date' },
          { name: 'start_required', type: 'boolean', description: 'Require start date', default: true },
          { name: 'end_required', type: 'boolean', description: 'Require end date', default: true },
          { name: 'allow_nil', type: 'boolean', description: 'Allow NULL values', default: false }
        ]
      },
      'RadSearch::BooleanFilter' => {
        label: 'Boolean',
        description: 'True/false filtering',
        compatible_types: %w[boolean],
        options: []
      },
      'RadSearch::SearchFilter' => {
        label: 'Dropdown',
        description: 'Dropdown selection',
        compatible_types: %w[string text rich_text attachment integer bigint decimal float],
        options: []
      },
      'RadSearch::ArrayFilter' => {
        label: 'Dropdown (Array)',
        description: 'Multi-select from array values',
        compatible_types: %w[array],
        options: []
      },
      'RadSearch::EnumFilter' => {
        label: 'Enum',
        description: 'Enum value filtering',
        compatible_types: [], # Determined by column metadata, not type
        options: []
      }
    }.freeze

    class << self
      def column_type_filters
        @column_type_filters ||= begin
          mapping = {}

          FILTERS.each do |class_name, config|
            config[:compatible_types].each do |col_type|
              mapping[col_type] ||= []
              mapping[col_type] << [config[:label], class_name]
            end
          end

          mapping
        end
      end

      def all
        FILTERS
      end

      def find(class_name)
        FILTERS[class_name]
      end

      def all_options
        FILTERS.map { |class_name, config| [config[:label], class_name] }
      end

      def filters_for_column_type(column_type)
        options = column_type_filters[column_type.to_s] || column_type_filters['string']
        options.map { |_label, class_name| class_name }
      end

      def options_for_column_type(column_type)
        column_type_filters[column_type.to_s] || column_type_filters['string']
      end

      def filter_options(class_name)
        filter = FILTERS[class_name]
        return [] unless filter

        filter[:options]
      end
    end
  end
end

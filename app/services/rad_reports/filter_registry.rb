module RadReports
  class FilterRegistry
    FILTERS = {
      'RadSearch::LikeFilter' => {
        label: 'Text Search (LIKE)',
        description: 'Case-insensitive text search',
        compatible_types: %w[string text rich_text attachment],
        filter_class: RadSearch::LikeFilter
      },
      'RadSearch::EqualsFilter' => {
        label: 'Exact Match',
        description: 'Exact value matching',
        compatible_types: %w[string text rich_text attachment integer bigint decimal float],
        filter_class: RadSearch::EqualsFilter
      },
      'RadSearch::DateFilter' => {
        label: 'Date Range',
        description: 'Date range filtering',
        compatible_types: %w[date datetime timestamp],
        filter_class: RadSearch::DateFilter
      },
      'RadSearch::BooleanFilter' => {
        label: 'Boolean',
        description: 'True/false filtering',
        compatible_types: %w[boolean],
        filter_class: RadSearch::BooleanFilter
      },
      'RadSearch::SearchFilter' => {
        label: 'Dropdown',
        description: 'Dropdown selection',
        compatible_types: %w[string text rich_text attachment integer bigint decimal float],
        filter_class: RadSearch::SearchFilter
      },
      'RadSearch::SearchFilterMultiple' => {
        label: 'Dropdown Multiple',
        description: 'Multi-select dropdown selection',
        compatible_types: %w[string text rich_text attachment integer bigint decimal float],
        filter_class: RadSearch::SearchFilter
      },
      'RadSearch::ArrayFilter' => {
        label: 'Dropdown (Array)',
        description: 'Multi-select from array values',
        compatible_types: %w[array],
        filter_class: RadSearch::ArrayFilter
      },
      'RadSearch::EnumFilter' => {
        label: 'Enum',
        description: 'Enum value filtering',
        compatible_types: [], # Determined by column metadata, not type
        filter_class: RadSearch::EnumFilter
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

      def filter_class(class_name)
        find(class_name)[:filter_class]
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
    end
  end
end

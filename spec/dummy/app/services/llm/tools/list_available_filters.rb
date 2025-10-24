module LLM
  module Tools
    class ListAvailableFilters < Base
      def description
        'Lists all available filter types and which column data types they can be used with. Use this to determine valid filter configurations for a report.'
      end

      def call
        result = "Available Filter Types:\n\n"

        # Overall available types
        result += "All Filter Types:\n"
        result += "- Text Search (LIKE): RadSearch::LikeFilter - Case-insensitive text search\n"
        result += "- Exact Match: RadSearch::EqualsFilter - Exact value matching\n"
        result += "- Date Range: RadSearch::DateFilter - Date range filtering\n"
        result += "- Boolean: RadSearch::BooleanFilter - True/false filtering\n"
        result += "- Dropdown: RadSearch::SearchFilter - Dropdown selection\n"
        result += "- Dropdown (Array): RadSearch::ArrayFilter - Multi-select from array values\n"
        result += "- Enum: RadSearch::EnumFilter - Enum value filtering\n\n"

        result += "Filter Types by Column Data Type:\n\n"

        # Get the filter types by column type
        filter_map = {
          'date/datetime/timestamp' => available_filter_types_for_column('date'),
          'boolean' => available_filter_types_for_column('boolean'),
          'integer/bigint/decimal/float' => available_filter_types_for_column('integer'),
          'string/text' => available_filter_types_for_column('string'),
          'array' => available_filter_types_for_column('array')
        }

        filter_map.each do |col_type, filters|
          result += "#{col_type.upcase}:\n"
          filters.each do |label, class_name|
            result += "  - #{label}: #{class_name}\n"
          end
          result += "\n"
        end

        result += "When creating filters, use:\n"
        result += "- column: The full column path (e.g., 'users.email', 'division.name')\n"
        result += "- label: Human-readable label for the filter\n"
        result += "- type: The filter class name (e.g., 'RadSearch::LikeFilter')\n"
        result += "- data_type: The column's data type (e.g., 'string', 'boolean', 'date')\n"

        result
      end

      private

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
          [all_filters[:date]]
        when 'boolean'
          [all_filters[:boolean]]
        when 'integer', 'bigint', 'decimal', 'float'
          [all_filters[:equals], all_filters[:dropdown]]
        when 'array'
          filters = [all_filters[:like], all_filters[:equals], all_filters[:dropdown], all_filters[:array]]
          filters
        else
          [all_filters[:like], all_filters[:equals], all_filters[:dropdown]]
        end
      end
    end
  end
end

module LLM
  module Tools
    class ListAvailableFilters < Base
      def description
        'Lists all available filter types and which column data types they can be used with. Use this to determine valid filter configurations for a report.'
      end

      def call
        result = "Available Filter Types:\n\n"

        result += "All Filter Types:\n"
        RadReports::FilterRegistry.all.each do |class_name, config|
          result += "- #{config[:label]}: #{class_name}\n"
          result += "  Description: #{config[:description]}\n"

          if config[:options].any?
            result += "  Available Options:\n"
            config[:options].each do |opt|
              opt_desc = "    * #{opt[:name]} (#{opt[:type]})"
              opt_desc += " - #{opt[:description]}" if opt[:description]
              opt_desc += " - default: #{opt[:default]}" if opt[:default]
              result += "#{opt_desc}\n"
            end
          end
          result += "\n"
        end

        result += "Filter Types by Column Data Type:\n\n"

        RadReports::FilterRegistry.column_type_filters.each do |col_type, filters|
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
        result += "- options: (Optional) Object with filter-specific options like default values\n"

        result
      end
    end
  end
end

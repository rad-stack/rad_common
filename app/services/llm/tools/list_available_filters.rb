module LLM
  module Tools
    class ListAvailableFilters < Base
      def description
        'Lists all available filter types and which column data types they can be used with. ' \
          'Use this to determine valid filter configurations for a report.'
      end

      def call
        <<~TEXT
          All Filter Types:
          #{filter_details}

          Filter Types by Column Data Type:
          #{column_details}
        TEXT
      end

      private

        def column_details
          RadReports::FilterRegistry.column_type_filters.map { |col_type, filters|
            lines = ["#{col_type.upcase}:"]
            lines += filters.map { |label, class_name| "  - #{label}: #{class_name}" }
            "#{lines.join("\n")}\n"
          }.join("\n")
        end

        def filter_details
          RadReports::FilterRegistry.all.map { |class_name, config|
            "- #{config[:label]}: #{class_name}\n  Description: #{config[:description]}"
          }.join("\n")
        end
    end
  end
end

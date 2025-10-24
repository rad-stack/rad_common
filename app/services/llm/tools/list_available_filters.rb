module LLM
  module Tools
    class ListAvailableFilters < Base
      HEADER_TEXT = <<~TEXT.freeze
        Available Filter Types:

      TEXT

      FOOTER_TEXT = <<~TEXT.freeze
        When creating filters, use:
        - column: The full column path (e.g., 'users.email', 'division.name')
        - label: Human-readable label for the filter
        - type: The filter class name (e.g., 'RadSearch::LikeFilter')
        - data_type: The column's data type (e.g., 'string', 'boolean', 'date')
        - options: (Optional) Object with filter-specific options like default values
      TEXT

      def description
        'Lists all available filter types and which column data types they can be used with. ' \
          'Use this to determine valid filter configurations for a report.'
      end

      def call
        sections = [HEADER_TEXT, all_filters_section, column_type_section, FOOTER_TEXT]
        format("%s\n", sections.join("\n").strip)
      end

      private

        def all_filters_section
          filter_details = RadReports::FilterRegistry.all.map do |class_name, config|
            filter_entry(class_name, config)
          end

          <<~TEXT
            All Filter Types:
            #{filter_details.join("\n\n")}

          TEXT
        end

        def filter_entry(class_name, config)
          lines = []
          lines << "- #{config[:label]}: #{class_name}"
          lines << "  Description: #{config[:description]}"

          return lines.join("\n") unless config[:options].any?

          lines << '  Available Options:'
          lines.concat(option_lines(config[:options]))
          lines.join("\n")
        end

        def option_lines(options)
          options.map do |opt|
            parts = ["    * #{opt[:name]} (#{opt[:type]})"]
            parts << opt[:description] if opt[:description]
            parts << "default: #{opt[:default]}" if opt[:default]
            parts.join(' - ')
          end
        end

        def column_type_section
          entries = RadReports::FilterRegistry.column_type_filters.map do |col_type, filters|
            column_type_entry(col_type, filters)
          end

          <<~TEXT
            Filter Types by Column Data Type:

            #{entries.join("\n")}
          TEXT
        end

        def column_type_entry(col_type, filters)
          lines = ["#{col_type.upcase}:"]
          lines.concat(filters.map { |label, class_name| "  - #{label}: #{class_name}" })
          "#{lines.join("\n")}\n"
        end
    end
  end
end

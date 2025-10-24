module LLM
  module Tools
    class ListAvailableFormulas < Base
      HEADER_TEXT = <<~TEXT.freeze
        Available Column Formulas:

      TEXT

      DEFAULT_USAGE_TEXT = <<~TEXT.freeze
        DEFAULT FORMULAS BY COLUMN TYPE:
          These are automatically applied unless you specify otherwise:
            - boolean → YES_NO (converts true/false to Yes/No)
            - date/datetime/timestamp → FORMAT_DATE (formats as MM/DD/YYYY)
            - array → ARRAY_JOIN (joins array elements with comma separator)

        USAGE:
          Include formulas in column configuration as an array of transformations:
            { "name": "active", "label": "Status", "select": "users.active", "formula": [{"type": "YES_NO"}] }
            { "name": "created_at", "label": "Created", "select": "users.created_at", "formula": [{"type": "FORMAT_DATE", "params": {"format": "%m/%d/%Y"}}] }

          Formulas can be chained - they are applied in order.
      TEXT

      def description
        'Lists all available formulas that can be applied to column values in reports. ' \
          'Use this to understand what transformations are possible.'
      end

      def call
        sections = [HEADER_TEXT]

        RadReports::FormulaRegistry.grouped_options.each do |category, formulas|
          sections << category_section(category, formulas)
        end

        sections << DEFAULT_USAGE_TEXT
        format("%s\n", sections.join("\n").strip)
      end

      private

        def category_section(category, formulas)
          <<~TEXT
            #{category.upcase} FORMULAS:
            #{formula_entries(formulas)}

          TEXT
        end

        def formula_entries(formulas)
          formulas.map { |label, type| formula_entry(type, label) }.join("\n\n")
        end

        def formula_entry(type, label)
          lines = ["  - #{type}: #{label}"]
          params = RadReports::FormulaRegistry.find(type)[:params]

          if params.any?
            lines << '    Parameters:'
            lines.concat(parameter_lines(params))
          else
            lines << '    (no parameters required)'
          end

          lines.join("\n")
        end

        def parameter_lines(params)
          params.map do |param|
            parts = ["      * #{param[:name]} (#{param[:type]})"]
            parts << "default: #{param[:default]}" if param[:default]
            parts << param[:label] if param[:label]
            parts.join(' - ')
          end
        end
    end
  end
end

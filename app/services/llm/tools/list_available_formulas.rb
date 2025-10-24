module LLM
  module Tools
    class ListAvailableFormulas < Base
      def description
        'Lists all available formulas that can be applied to column values in reports. Use this to understand what transformations are possible.'
      end

      def call
        result = "Available Column Formulas:\n\n"

        # Group by category
        grouped = RadReports::FormulaRegistry.grouped_options

        grouped.each do |category, formulas|
          result += "#{category.upcase} FORMULAS:\n"
          formulas.each do |label, type|
            formula_def = RadReports::FormulaRegistry.find(type)
            result += "  - #{type}: #{label}\n"

            if formula_def[:params].any?
              result += "    Parameters:\n"
              formula_def[:params].each do |param|
                param_desc = "      * #{param[:name]} (#{param[:type]})"
                param_desc += " - default: #{param[:default]}" if param[:default]
                param_desc += " - #{param[:label]}" if param[:label]
                result += "#{param_desc}\n"
              end
            else
              result += "    (no parameters required)\n"
            end
            result += "\n"
          end
        end

        result += "DEFAULT FORMULAS BY COLUMN TYPE:\n"
        result += "These are automatically applied unless you specify otherwise:\n"
        result += "  - boolean → YES_NO (converts true/false to Yes/No)\n"
        result += "  - date/datetime/timestamp → FORMAT_DATE (formats as MM/DD/YYYY)\n"
        result += "  - array → ARRAY_JOIN (joins array elements with comma separator)\n\n"

        result += "USAGE:\n"
        result += "Include formulas in column configuration as an array of transformations:\n"
        result += "  { \"name\": \"active\", \"label\": \"Status\", \"select\": \"users.active\", \"formula\": [{\"type\": \"YES_NO\"}] }\n"
        result += "  { \"name\": \"created_at\", \"label\": \"Created\", \"select\": \"users.created_at\", \"formula\": [{\"type\": \"FORMAT_DATE\", \"params\": {\"format\": \"%m/%d/%Y\"}}] }\n"
        result += "\nFormulas can be chained - they are applied in order.\n"

        result
      end
    end
  end
end

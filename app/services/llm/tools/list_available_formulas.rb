module LLM
  module Tools
    class ListAvailableFormulas < Base
      def description
        'Lists all available formulas that can be applied to column values in reports. ' \
          'Use this to understand what transformations are possible.'
      end

      def call
        <<~TEXT
          #{formula_details}

          IMPORTANT NOTES:
          - Default formulas are automatically applied based on column type unless you override them:
            * boolean → YES_NO (converts true/false to Yes/No)
            * date/datetime/timestamp → FORMAT_DATE (formats as MM/DD/YYYY)
            * array → ARRAY_JOIN (joins array elements with comma separator)
          - Formulas can be chained and are applied in the order specified
        TEXT
      end

      private

        def formula_details
          RadReports::FormulaRegistry.grouped_options.map { |category, formulas|
            "#{category.upcase} FORMULAS:\n#{format_formulas(formulas)}"
          }.join("\n\n")
        end

        def format_formulas(formulas)
          formulas.map { |label, type|
            params = RadReports::FormulaRegistry.find(type)[:params]
            param_info = if params.any?
                           "Parameters:\n#{format_params(params)}"
                         else
                           '(no parameters required)'
                         end
            "  - #{type}: #{label}\n    #{param_info}"
          }.join("\n\n")
        end

        def format_params(params)
          params.map { |param|
            parts = ["      * #{param[:name]} (#{param[:type]})"]
            parts << "default: #{param[:default]}" if param[:default]
            parts << param[:label] if param[:label]
            parts.join(' - ')
          }.join("\n")
        end
    end
  end
end

module LLM
  module Tools
    class ListAvailableFormulas < Base
      def description
        'Lists all available formulas that can be applied to column values in reports. ' \
          'Use this to understand what transformations are possible.'
      end

      def call
        <<~TEXT
          ## TRANSFORM FORMULAS (for existing database columns)
          #{transform_formula_details}

          ## CALCULATED FORMULAS (create new columns by combining multiple columns)
          #{calculated_formula_details}

          IMPORTANT NOTES:
          - **Transform formulas** are applied to existing database columns that have a "select" field
          - **Calculated formulas** create entirely new columns by combining multiple database columns
          - Calculated columns must have "is_calculated": true and "sortable": false
          - Default formulas are automatically applied based on column type unless you override them:
            * boolean → YES_NO (converts true/false to Yes/No)
            * date/datetime/timestamp → FORMAT_DATE (formats as MM/DD/YYYY)
            * array → ARRAY_JOIN (joins array elements with comma separator)
          - Formulas can be chained and are applied in the order specified
          - For calculated formulas, column references in params must use exact "select" paths from list_model_columns
        TEXT
      end

      private

        def transform_formula_details
          RadReports::FormulaRegistry.grouped_options.map { |category, formulas|
            "#{category.upcase}:\n#{format_formulas(formulas)}"
          }.join("\n\n")
        end

        def calculated_formula_details
          RadReports::FormulaRegistry.calculated_grouped_options.map { |category, formulas|
            "#{category.upcase}:\n#{format_calculated_formulas(formulas)}"
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

        def format_calculated_formulas(formulas)
          formulas.map { |label, type|
            params = RadReports::FormulaRegistry.find(type)[:params]
            param_info = if params.any?
                           "Parameters:\n#{format_params(params)}"
                         else
                           '(no parameters required)'
                         end
            "  - #{type}: #{label} [CALCULATED COLUMN]\n    #{param_info}\n    Usage: Creates new column by combining multiple database columns"
          }.join("\n\n")
        end

        def format_params(params)
          params.map { |param|
            parts = ["      * #{param[:name]} (#{param[:type]})"]
            parts << "default: #{param[:default]}" if param[:default]
            parts << param[:label] if param[:label]
            if param[:type] == 'column_selector'
              parts << 'IMPORTANT: Use exact "select" paths from list_model_columns'
            end
            parts.join(' - ')
          }.join("\n")
        end
    end
  end
end

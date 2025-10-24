module LLM
  module Tools
    class ListModelColumns < Base
      def description
        'Lists all available columns for a specific model, including columns from joined associations'
      end

      def required_params
        [:model_name]
      end

      def parameters
        {
          type: 'object',
          properties: {
            model_name: {
              type: 'string',
              description: 'The model name (e.g., "User", "Company")'
            },
            joins: {
              type: 'array',
              description: 'Optional array of association paths to include columns from (e.g., ["division", "division.company"])',
              items: { type: 'string' }
            }
          }
        }
      end

      def call
        model_name = retrieve_argument(:model_name)
        joins = retrieve_argument(:joins) || []

        discovery = RadReports::ColumnDiscovery.new(model_name, joins)
        columns = discovery.all_columns

        columns_by_table = discovery.columns_by_table

        result = "Columns available for #{model_name}:\n\n"
        result += "IMPORTANT: Use the exact 'select' value shown below when configuring columns.\n\n"

        columns_by_table.each do |table_info, cols|
          table_label = table_info[:association_label] || table_info[:class_label]
          result += "#{table_label}:\n"

          cols.each do |col|
            # Build the select path using association or table
            select_prefix = col[:association] || col[:table]
            select_path = "#{select_prefix}.#{col[:name]}"

            result += "  - name: #{col[:name]}\n"
            result += "    type: #{col[:type]}\n"
            result += "    select: #{select_path}\n"
            result += "    [Foreign Key]" if col[:is_foreign_key]
            result += "    [Enum]" if col[:is_enum]
            result += "\n"
          end

          result += "\n"
        end

        result += "\nColumn Configuration Format:\n"
        result += "When adding a column to your report, use this structure:\n"
        result += "{\n"
        result += "  \"name\": \"<column name from above>\",\n"
        result += "  \"label\": \"<human readable label>\",\n"
        result += "  \"select\": \"<exact select value from above>\"\n"
        result += "}\n"

        result
      end
    end
  end
end

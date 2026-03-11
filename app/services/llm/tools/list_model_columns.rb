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
              description: 'Optional array of association paths (e.g., ["division", "division.company"])',
              items: { type: 'string' }
            }
          }
        }
      end

      def call
        model_name = retrieve_argument(:model_name)
        joins = retrieve_argument(:joins) || []

        discovery = RadReports::ColumnDiscovery.new(model_name, joins)
        sections = [header(model_name), table_sections(discovery.columns_by_table)]

        "#{sections.compact.join("\n").strip}\n"
      end

      private

        def header(model_name)
          "Columns available for #{model_name}:\n\n"
        end

        def table_sections(columns_by_table)
          columns_by_table.map { |table_info, columns| table_section(table_info, columns) }.join("\n")
        end

        def table_section(table_info, columns)
          table_label = table_info[:association_label] || table_info[:class_label]
          lines = ["#{table_label}:"]
          lines.concat(columns.map { |column| column_entry(column) })
          "#{lines.join("\n")}\n"
        end

        def column_entry(column)
          select_prefix = column[:association] || column[:table]
          select_path = "#{select_prefix}.#{column[:name]}"

          details = []
          details << "  - name: #{column[:name]}"
          details << "    type: #{column[:type]}"
          details << "    select: #{select_path}"
          details << '    [Foreign Key]' if column[:is_foreign_key]
          details << '    [Enum]' if column[:is_enum]
          details << ''
          details.join("\n")
        end
    end
  end
end

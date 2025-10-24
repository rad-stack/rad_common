module LLM
  module Tools
    class ListModelAssociations < Base
      def description
        'Lists all available associations (relationships) for a specific model that can be joined in a custom report'
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
            current_joins: {
              type: 'array',
              description: 'Optional array of currently selected join paths',
              items: { type: 'string' }
            }
          }
        }
      end

      def call
        model_name = retrieve_argument(:model_name)
        current_joins = retrieve_argument(:current_joins) || []

        discovery = RadReports::AssociationDiscovery.new(model_name, current_joins)
        associations = discovery.available_associations

        result = "Available associations for #{model_name}:\n\n"

        associations.each do |assoc|
          result += "- #{assoc[:name]} (#{assoc[:type]} → #{assoc[:class_name]})\n"
          result += "  Table: #{assoc[:table_name]}\n"
          result += "  Description: #{assoc[:type].humanize} relationship to #{assoc[:class_name]}\n\n"
        end

        if associations.empty?
          result += "No available associations found.\n"
        end

        result
      end
    end
  end
end

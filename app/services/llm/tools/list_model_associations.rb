module LLM
  module Tools
    class ListModelAssociations < Base
      def description
        'Lists all available associations (relationships) for a specific model that can be joined in a custom report. IMPORTANT: Pass current_joins parameter to discover nested associations. For example, after adding "project" join, call again with current_joins: ["project"] to see "project.client" and other nested options.'
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
              description: 'Optional array of currently selected join paths. Pass this to discover nested associations. Example: ["project"] reveals "project.client", "project.company", etc.',
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

        result = "Available associations for #{model_name}"
        result += " (with current joins: #{current_joins.join(', ')})" if current_joins.any?
        result += ":\n\n"

        # Separate direct and nested associations
        direct = associations.select { |a| !a[:name].include?('.') }
        nested = associations.select { |a| a[:name].include?('.') }

        if direct.any?
          result += "DIRECT ASSOCIATIONS:\n"
          direct.each do |assoc|
            result += "- #{assoc[:name]} (#{assoc[:type]} → #{assoc[:class_name]})\n"
            result += "  Use in joins as: \"#{assoc[:name]}\"\n\n"
          end
        end

        if nested.any?
          result += "NESTED ASSOCIATIONS:\n"
          result += "(These become available when you add the parent join)\n\n"
          nested.each do |assoc|
            result += "- #{assoc[:name]} (#{assoc[:type]} → #{assoc[:class_name]})\n"
            result += "  Use in joins as: \"#{assoc[:name]}\"\n\n"
          end
        end

        if associations.empty?
          result += "No additional associations available.\n"
        end

        if current_joins.empty?
          result += "\nNOTE: To see nested associations (e.g., through 'project' to 'client'),\n"
          result += "call this tool again after adding a join, passing the join in current_joins.\n"
          result += "Example: After adding 'project' join, call with current_joins: [\"project\"]\n"
          result += "to see associations available through project (like project.client).\n"
        end

        result
      end
    end
  end
end

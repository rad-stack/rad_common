module LLM
  module Tools
    class ListModelAssociations < Base
      NOTE_TEXT = <<~TEXT.freeze

        NOTE: To see nested associations (e.g., through 'project' to 'client'),
        call this tool again after adding a join, passing the join in current_joins.
        Example: After adding 'project' join, call with current_joins: ["project"]
        to see associations available through project (like project.client).
      TEXT

      def description
        'Lists all available associations/relationships for a specific model that can be joined in a custom report. ' \
          'IMPORTANT: Pass current_joins parameter to discover nested associations. ' \
          'For example, after adding "project" join, call again with current_joins: ' \
          '["project"] to see "project.client" and other nested options.'
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

        sections = [header(model_name, current_joins)]
        sections << direct_section(associations)
        sections << nested_section(associations)
        sections << 'No additional associations available.' if associations.empty?
        sections << NOTE_TEXT if current_joins.empty?

        "#{sections.compact.join("\n").strip}\n"
      end

      private

        def header(model_name, current_joins)
          base = "Available associations for #{model_name}"
          base += " (with current joins: #{current_joins.join(', ')})" if current_joins.any?
          "#{base}:\n"
        end

        def direct_section(associations)
          direct = associations.reject { |assoc| nested_association?(assoc) }
          return if direct.empty?

          lines = ['DIRECT ASSOCIATIONS:']
          lines.concat(association_lines(direct))
          "#{lines.join("\n")}\n"
        end

        def nested_section(associations)
          nested = associations.select { |assoc| nested_association?(assoc) }
          return if nested.empty?

          lines = ['NESTED ASSOCIATIONS:', '(These become available when you add the parent join)']
          lines.concat(association_lines(nested))
          "#{lines.join("\n")}\n"
        end

        def association_lines(associations)
          associations.map do |assoc|
            <<~TEXT.rstrip
              - #{assoc[:name]} (#{assoc[:type]} → #{assoc[:class_name]})
                Use in joins as: "#{assoc[:name]}"
            TEXT
          end
        end

        def nested_association?(association)
          association[:name].include?('.')
        end
    end
  end
end

module LLM
  module Tools
    class AttorneyDataTool < Base
      TOOL_DESCRIPTION = <<~EXAMPLES.freeze
        This tool is designed to provide basic data about attorneys.
        It provides the contact information for attorneys.
      EXAMPLES
      def call
        Embedding.search([retrieve_argument('attorney_name')], type: 'Attorney').as_json.to_s
      end

      def required_params
        ['attorney_name']
      end

      def parameters
        {
          type: 'object',
          properties: {
            attorney_name: {
              type: 'string',
              description: 'The full name of the attorney'
            }
          }
        }
      end

      def description
        TOOL_DESCRIPTION
      end
    end
  end
end

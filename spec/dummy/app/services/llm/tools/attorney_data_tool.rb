module LLM
  module Tools
    class AttorneyDataTool < Base
      TOOL_DESCRIPTION = <<~EXAMPLES.freeze
        This tool is designed to provide basic data about attorneys.
        It provides the contact information for attorneys.
      EXAMPLES
      def call
        attorney.as_json.to_s
      end

      def attorney_name_embedding
        @attorney_name_embedding ||= EmbeddingService.new(retrieve_argument('attorney_name').generate)
      end

      def attorney
        return 'No Data Found' if embedding.blank?

        embedding.first.embeddable
      end

      def embedding
        @embedding ||= Embedding.search(attorney_name_embedding, type: 'Attorney')
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

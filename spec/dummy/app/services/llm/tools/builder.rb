module LLM
  module Tools
    class Builder
      TOOLS = [CRNAUserPreferenceDataTool, CRNAUserMallowScoreTool].freeze

      def initialize(name:, description:, required_params: [], parameters: {})
        @name = name
        @description = description
        @required_params = required_params
        @parameters = parameters
      end

      def self.respond_to_tool_call(response, context, messages)
        tool_class = LLM::Tools::Builder.tools[response.tool_name]
        tool_instance = tool_class.new(params: response.tool_data, context: context)
        result = tool_instance.call
        tool_message = response.message
        result_message = LLM::PromptBuilder.build_message(role: :tool, content: result,
                                                          tool_call_id: response.tool_call_id)
        messages + [tool_message, result_message]
      end

      def self.tools
        @tools ||= TOOLS.index_by { |class_object| tool_name(class_object) }
      end

      def self.tool_name(class_object)
        class_object.name.demodulize.underscore
      end

      def tool_definition
        { type: 'function',
          function: {
            name: @name, description: @description, parameters: @parameters, required: @required_params
          } }
      end
    end
  end
end

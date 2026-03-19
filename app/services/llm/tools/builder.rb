module LLM
  module Tools
    class Builder
      def initialize(name:, description:, required_params: [], parameters: {})
        @name = name
        @description = description
        @required_params = required_params
        @parameters = parameters
      end

      def self.respond_to_tool_calls(response, context, messages)
        tool_messages = response.tool_calls.map { |tool_call| respond_to_tool_call(tool_call, response, context) }
        tool_message = response.message
        messages + [tool_message] + tool_messages
      end

      def self.respond_to_tool_call(tool_call, response, context)
        tool_class = context.chat_instance.available_tools[response.tool_name(tool_call)]
        tool_instance = tool_class.new(params: response.tool_data(tool_call), context: context)
        result = tool_instance.call
        LLM::PromptBuilder.build_message(role: :tool, content: result,
                                         tool_call_id: response.tool_call_id(tool_call))
      end

      def self.tools
        @tools ||= RadAssistant.system_tools.index_by { |class_object| tool_name(class_object) }
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

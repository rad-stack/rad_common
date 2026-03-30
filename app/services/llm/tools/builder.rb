module LLM
  module Tools
    class Builder
      def initialize(name:, description:, required_params: [], parameters: {})
        @name = name
        @description = description
        @required_params = required_params
        @parameters = parameters
      end

      def self.respond_to_tool_calls(response, context)
        function_call_outputs = response.tool_calls.map { |tool_call| respond_to_tool_call(tool_call, context) }
        response.output_items + function_call_outputs
      end

      def self.respond_to_tool_call(tool_call, context)
        tool_class = context.chat_instance.available_tools[tool_call['name']]
        tool_instance = tool_class.new(params: tool_call, context: context)
        result = tool_instance.call
        { type: 'function_call_output', call_id: tool_call['call_id'], output: result.to_s }
      end

      def self.tools
        @tools ||= RadAssistant.system_tools.index_by { |class_object| tool_name(class_object) }
      end

      def self.tool_name(class_object)
        class_object.name.demodulize.underscore
      end

      def tool_definition
        definition = { type: 'function', name: @name, description: @description }
        if @parameters.present?
          params = @parameters.dup
          params[:required] = @required_params if @required_params.present?
          definition[:parameters] = params
        end
        definition
      end
    end
  end
end

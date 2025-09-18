module LLM
  module Tools
    class Base
      include RadHelper

      delegate :tool_definition, to: :tool

      def initialize(params: {}, context: nil)
        @params = params
        @arguments_raw = params['arguments']
        @arguments = JSON.parse(@arguments_raw) if @arguments_raw.present?
        @context = context
      end

      def tool
        @tool ||= Builder.new(name: name, description: description)
      end

      def name
        LLM::Tools::Builder.tool_name(self.class)
      end

      def description
        raise NotImplementedError
      end
    end
  end
end

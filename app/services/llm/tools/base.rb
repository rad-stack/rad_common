module LLM
  module Tools
    class Base
      include RadHelper

      delegate :tool_definition, to: :tool

      def initialize(params: {}, context: nil)
        @params = params
        @arguments_raw = params['arguments']
        @arguments = {}
        @arguments = JSON.parse(@arguments_raw) if @arguments_raw.present?
        @context = context
      end

      def tool
        @tool ||= Builder.new(name: name, description: description, required_params: required_params,
                              parameters: parameters)
      end

      def required_params
        []
      end

      def retrieve_argument(name)
        @arguments[name]
      end

      def parameters
        {}
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

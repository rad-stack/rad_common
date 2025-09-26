module LLM
  module Tools
    class Base
      include RadHelper

      delegate :tool_definition, to: :tool

      def initialize(params: {}, context: nil)
        @params = params.symbolize_keys
        @arguments_raw = @params[:arguments]
        @context = context
      end

      def tool
        @tool ||= Builder.new(name: name, description: description, required_params: required_params,
                              parameters: parameters)
      end

      def arguments
        @arguments ||= if @arguments_raw.blank?
                         {}
                       elsif @arguments_raw.is_a?(String)
                         JSON.parse(@arguments_raw).symbolize_keys
                       else
                         @arguments_raw.symbolize_keys
                       end
      end

      def required_params
        []
      end

      def retrieve_argument(name)
        arguments[name.to_sym]
      end

      def retrieve_required_params
        required_params.map do |param|
          arguments[param]
        end
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

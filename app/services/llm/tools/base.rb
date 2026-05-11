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

      # LLMs often pass 0 or null when they mean "no filter", this handles that case.
      def positive_id(param_name)
        value = retrieve_argument(param_name).to_i
        value.positive? ? value : nil
      end

      # Usage in parameters method:
      #   properties: {
      #     **self.class.id_parameter(:user),
      #     **self.class.id_parameter(:room, description: 'Filter by room ID')
      #   }
      def self.id_parameter(name, description: nil)
        param_name = "#{name}_id"
        desc = description || "The #{name.to_s.humanize.downcase} ID (from mentioned entities if available)"
        { param_name.to_sym => { type: 'integer', description: desc } }
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

      def data_expiration
        nil
      end
    end
  end
end

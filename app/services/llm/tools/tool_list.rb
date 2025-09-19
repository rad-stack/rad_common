module LLM
  module Tools
    class ToolList
      def self.tool_list
        []
      end

      def self.chat_list
        { basic: LLM::ChatTypes::SystemChat }
      end

      def self.default_chat_type
        'basic'
      end
    end
  end
end

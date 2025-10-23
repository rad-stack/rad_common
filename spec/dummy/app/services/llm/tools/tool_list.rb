module LLM
  module Tools
    class ToolList
      def self.tools
        [AttorneyDataTool]
      end

      def self.chat_list
        { basic: LLM::ChatTypes::AttorneyChat }
      end

      def self.default_chat_type
        'basic'
      end
    end
  end
end

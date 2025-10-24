module LLM
  module Tools
    class ToolList
      def self.tools
        # Include engine tools plus app-specific tools
        super + [AttorneyDataTool]
      end

      def self.chat_list
        # Include engine chat types plus app-specific chats
        super.merge({ attorney: LLM::ChatTypes::AttorneyChat })
      end
    end
  end
end

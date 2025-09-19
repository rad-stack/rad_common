module LLM
  module ChatTypes
    class SystemChat < BaseChat
      include RadHelper

      COMMON_QUESTIONS = [LLM::CommonQuestions::AttorneyPhoneNumberQuestion].freeze

      SYSTEM_PROMPT = <<~EXAMPLES.freeze
        You are a helpful assistant.
      EXAMPLES

      def self.common_questions
        COMMON_QUESTIONS
      end

      def system_prompt
        SYSTEM_PROMPT
      end

      private

        def default_tools
          @default_tools ||= LLM::Tools::ToolList.tools.map { |tool| tool.new.tool_definition }
        end
    end
  end
end

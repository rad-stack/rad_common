module LLM
  module ChatTypes
    class BasicChat < BaseChat
      include RadHelper

      ASSISTANT_NAME = 'Assistant'.freeze

      COMMON_QUESTIONS = [LLM::CommonQuestions::AttorneyPhoneNumberQuestion].freeze

      SYSTEM_PROMPT = <<~EXAMPLES.freeze
        You are a helpful assistant.
      EXAMPLES

      def common_question_class(question)
        @common_question_class ||= self.class.common_question_map[question]
      end

      def self.common_questions
        COMMON_QUESTIONS
      end

      def system_prompt
        SYSTEM_PROMPT
      end

      private

        def default_tools
          [LLM::Tools::AttorneyDataTool.new.tool_definition]
        end
    end
  end
end

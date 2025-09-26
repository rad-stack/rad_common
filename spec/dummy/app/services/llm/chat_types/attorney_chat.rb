module LLM
  module ChatTypes
    class AttorneyChat < BaseChat
      include RadHelper

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

      def input_collection(_view_context)
        Attorney.all.sorted
      end

      def grouped_select?
        false
      end

      def context_type
        'Attorney'
      end

      private

        def default_tools
          [LLM::Tools::AttorneyDataTool.new.tool_definition]
        end
    end
  end
end

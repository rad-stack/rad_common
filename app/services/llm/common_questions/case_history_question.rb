module LLM
  module CommonQuestions
    class CaseHistoryQuestion < Base
      QUESTION = <<~QUESTION.freeze
        Give me the number of times a case type was worked in this period for this user.
        List the case type that has been worked the most and its last start_time
      QUESTION

      USER_QUESTION = 'What were the last types of case this user has worked?'.freeze

      def self.question
        QUESTION
      end

      def self.user_question
        USER_QUESTION
      end

      def tool
        @tool ||= LLM::Tools::CRNACaseHistoryTool.new(context: @context)
      end
    end
  end
end

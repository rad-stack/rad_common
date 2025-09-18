module LLM
  module CommonQuestions
    class MallowScoreQuestion < Base
      QUESTION = <<~QUESTION.freeze
        What is the user's mallow score?
      QUESTION

      USER_QUESTION = "What is the user's mallow score?".freeze

      def self.question
        QUESTION
      end

      def self.user_question
        USER_QUESTION
      end

      def tool
        @tool ||= LLM::Tools::CRNAUserMallowScoreTool.new(context: @context)
      end
    end
  end
end

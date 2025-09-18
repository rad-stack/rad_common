module LLM
  module CommonQuestions
    class UserPreferenceQuestion < Base
      QUESTION = <<~QUESTION.freeze
        List the top 5 preferred rooms and their case types, room start and end time
      QUESTION

      USER_QUESTION = 'What rooms does the user prefer to work this day?'.freeze

      def self.question
        QUESTION
      end

      def self.user_question
        USER_QUESTION
      end

      def tool
        @tool ||= LLM::Tools::CRNAUserPreferenceDataTool.new(context: @context)
      end
    end
  end
end

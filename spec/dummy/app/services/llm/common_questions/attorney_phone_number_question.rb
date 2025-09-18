module LLM
  module CommonQuestions
    class AttorneyPhoneNumberQuestion < Base

      USER_QUESTION = 'What is the attorneys phone number?'.freeze

      def self.question
        USER_QUESTION
      end

      def self.user_question
        USER_QUESTION
      end

      def tool
        @tool ||= LLM::Tools::AttorneyDataTool.new(context: @context, params: { arguments: arguments })
      end

      def arguments
        { attorney_name: @context.contextable.to_s }
      end
    end
  end
end

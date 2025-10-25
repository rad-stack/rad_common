module LLM
  module CommonQuestions
    class Base
      def initialize(context:)
        @context = context
      end

      def self.question
        raise NotImplementedError
      end

      def self.user_question
        raise NotImplementedError
      end

      def context_data
        tool.call
      end

      def tool
        raise NotImplementedError
      end
    end
  end
end

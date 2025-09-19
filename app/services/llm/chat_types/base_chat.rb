module LLM
  module ChatTypes
    class BaseChat
      include RadHelper

      ASSISTANT_NAME = 'Assistant'.freeze

      def initialize(llm_chat)
        @llm_chat = llm_chat
        @common_question = false
      end

      def assistant_name
        ASSISTANT_NAME
      end

      def input_collection(view_context)
        UserGrouper.new(view_context.current_user, scopes: [:active])
      end

      def grouped_select?
        true
      end

      def context_type
        'User'
      end

      def basic_question(question)
        question = build_context(question)

        if @llm_chat.log.present?
          previous_messages = @llm_chat.log
          return base_prompt.chat(content: question, previous_messages: previous_messages)
        end

        base_prompt.chat(content: question)
      end

      def build_context(question)
        return question unless common_question_class(question)

        question_class = common_question_class(question)
        question_instance = question_class.new(context: @llm_chat)
        context_data = question_instance.context_data
        @common_question = context_data.present?
        "#{question} CONTEXT_DATA_FOLLOWS: \n #{question_instance.class.question} \n #{context_data}"
      end

      def common_question_class(question)
        @common_question_class ||= self.class.common_question_map[question]
      end

      def self.common_question_map
        @common_question_map ||= common_questions.index_by(&:user_question)
      end

      def self.common_questions
        raise NotImplementedError
      end

      def base_prompt
        @base_prompt = LLM::PromptBuilder.new(system_prompt: system_prompt,
                                              context: @llm_chat,
                                              tools: base_tools)
      end

      private

        def openai_client
          @openai_client ||= OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)
        end

        def system_prompt
          raise NotImplementedError
        end

        def base_tools
          return [] if @common_question

          default_tools
        end

        def default_tools
          raise NotImplementedError
        end
    end
  end
end

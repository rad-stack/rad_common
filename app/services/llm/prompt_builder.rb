module LLM
  class PromptBuilder
    include RadHelper

    SYSTEM_ROLE = 'system'.freeze
    ASSISTANT_ROLE = 'assistant'.freeze
    USER_ROLE = 'user'.freeze
    def initialize(model: 'gpt-4.1-mini', system_prompt: nil, tools: [], context: {})
      @model = model
      @system_prompt = system_prompt
      @tools = tools
      @context = context
    end

    def chat(content: nil, previous_messages: [])
      messages = []
      messages << build_system_prompt if previous_messages.empty?
      messages += previous_messages
      messages << PromptBuilder.build_user_message(content) if content
      r = openai_client.chat(
        parameters: {
          model: @model,
          messages: messages,
          tools: @tools
        }
      )
      response = ChatResponse.new(r)
      if response.tool_call?
        return chat(previous_messages: LLM::Tools::Builder.respond_to_tool_calls(response, @context, messages))
      end

      assistant_message = r.dig('choices', 0, 'message')
      assistant_message[:chat_date] = PromptBuilder.formatted_current_date_time
      [response.result, messages + [assistant_message]]
    end

    def build_system_prompt
      PromptBuilder.build_message(role: SYSTEM_ROLE, content: @system_prompt)
    end

    def build_messages(content)
      messages = []
      messages << PromptBuilder.build_message(role: SYSTEM_ROLE, content: @system_prompt) if @system_prompt.present?
      messages << PromptBuilder.build_message(role: USER_ROLE, content: content)
      messages
    end

    def self.build_message(role:, content:, tool_call_id: nil)
      data = { role: role, content: content, chat_date: formatted_current_date_time }
      data[:tool_call_id] = tool_call_id if tool_call_id.present?
      data
    end

    def self.build_user_message(content)
      build_message(role: USER_ROLE, content: content)
    end

    def self.build_assistant_message(content)
      build_message(role: ASSISTANT_ROLE, content: content)
    end

    def self.formatted_current_date_time
      ApplicationController.helpers.format_datetime(DateTime.current)
    end

    private

      def openai_client
        @openai_client ||= OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)
      end
  end
end

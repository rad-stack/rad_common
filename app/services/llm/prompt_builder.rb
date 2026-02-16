module LLM
  class PromptBuilder
    include RadHelper

    DEVELOPER_ROLE = 'developer'.freeze
    ASSISTANT_ROLE = 'assistant'.freeze
    USER_ROLE = 'user'.freeze

    def initialize(system_prompt: nil, tools: [], context: {}, model: RadCommon::OPEN_AI_CHAT_MODEL)
      @system_prompt = system_prompt
      @tools = tools
      @context = context
      @model = model
    end

    def chat(content: nil, previous_messages: [], response_format: nil)
      log_items = previous_messages.dup
      log_items << PromptBuilder.build_user_message(content) if content

      input_items = sanitize_for_api(log_items)
      parameters = { model: @model, input: input_items }
      apply_system_prompt(parameters, response_format)
      parameters[:tools] = @tools if @tools.present?
      parameters[:text] = { format: response_format } if response_format

      r = RadRetry.perform_request do
        openai_client.responses.create(parameters: parameters)
      rescue Faraday::BadRequestError => e
        raise e.response[:body]['error']['message']
      end

      response = ChatResponse.new(r)
      if response.tool_call?
        tool_items = LLM::Tools::Builder.respond_to_tool_calls(response, @context)
        return chat(previous_messages: log_items + tool_items)
      end

      log_items << PromptBuilder.build_assistant_message(response.result)
      [response.result, log_items]
    end

    def self.build_message(role:, content:)
      { role: role, content: content, chat_date: formatted_current_date_time }
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

      def apply_system_prompt(parameters, response_format)
        return if @system_prompt.blank?

        if response_format.present?
          parameters[:input].unshift({ role: DEVELOPER_ROLE, content: @system_prompt })
        else
          parameters[:instructions] = @system_prompt
        end
      end

      def sanitize_for_api(items)
        items.filter_map do |item|
          next unless item.is_a?(Hash)

          item = item.stringify_keys
          next if item['role'] == 'system'

          item.except('chat_date')
        end
      end

      def openai_client
        @openai_client ||= OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)
      end
  end
end

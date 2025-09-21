module LLM
  class ChatResponse
    def initialize(response)
      @response = response
    end

    def result
      @response.dig('choices', 0, 'message', 'content')
    end

    def tool_call?
      tool_calls.present?
    end

    def tool_name(tool_call)
      tool_data(tool_call)['name']
    end

    def tool_call_id(tool_call)
      tool_call['id']
    end

    def tool_data(tool_call)
      tool_call['function']
    end

    def tool_calls
      @tool_calls ||= @response.dig('choices', 0, 'message', 'tool_calls')
    end

    def message
      @message ||= @response.dig('choices', 0, 'message')
    end
  end
end

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

    def tool_name
      @tool_name ||= tool_data['name']
    end

    def tool_call_id
      @tool_call_id ||= tool_calls.first&.dig('id')
    end

    def tool_data
      @tool_data ||= tool_calls.first&.dig('function')
    end

    def tool_calls
      @tool_calls ||= @response.dig('choices', 0, 'message', 'tool_calls')
    end

    def message
      @message ||= @response.dig('choices', 0, 'message')
    end
  end
end

module LLM
  class ChatResponse
    def initialize(response)
      @response = response
    end

    def result
      # TODO: is there a better way to do this?
      @response.dig('output', 0, 'content', 0, 'text')
    end

    def tool_call?
      tool_calls.present?
    end

    def tool_name(tool_call)
      tool_call['name']
    end

    def tool_call_id(tool_call)
      tool_call['call_id']
    end

    def tool_calls
      @tool_calls ||= output_items.select { |item| item['type'] == 'function_call' }
    end

    def output_items
      @output_items ||= @response['output'] || []
    end
  end
end

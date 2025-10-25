class RadAssistant
  @chat_types = []
  @system_tools = []

  class << self
    attr_reader :chat_types, :system_tools

    def register_chat_type(chat_type)
      @chat_types << chat_type unless @chat_types.include?(chat_type)
      chat_type.default_tools.each { |tool| register_system_tool(tool) }
    end

    def register_system_tool(system_tool)
      @system_tools << system_tool unless @system_tools.include?(system_tool)
    end
  end

  def self.retrieve_chat_class(raw_type)
    chat_types.find { |type| type.name == raw_type }
  end
end

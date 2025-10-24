class RadAssistant
  @chat_types = []

  class << self
    attr_reader :chat_types

    def register(chat_type)
      @chat_types << chat_type unless @chat_types.include?(chat_type)
    end
  end

  def self.retrieve_chat_class(raw_type)
    chat_types.find { |type| type.name == raw_type }
  end
end

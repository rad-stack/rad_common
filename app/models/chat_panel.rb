class ChatPanel
  attr_reader :chat_list_id, :messages
  attr_accessor :additional_content

  def initialize(chat_list_id:, messages: [])
    @chat_list_id = chat_list_id
    @messages = messages
  end
end

module Chatable
  extend ActiveSupport::Concern

  included do
    attr_accessor :current_message
  end

  def chat_list_id
    raise NotImplementedError
  end

  def input_id
    "#{self.class.name.underscore}_current_message"
  end

  def input_name
    "#{self.class.name.underscore}[current_message]"
  end

  def create_message(message:, user:)
    raise NotImplementedError
  end

  def chat_message_from_log(log_entry, current_user)
    raise NotImplementedError
  end
end

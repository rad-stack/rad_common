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

  def chat_permitted_params
    [:current_message]
  end

  def prepare_for_chat_update(_params, _current_user)
    nil
  end

  def handle_blank_chat_message(_current_user)
    nil
  end

  def after_chat_message_created(_current_user); end

  def after_update_partial
    nil
  end

  def after_update_locals
    {}
  end
end

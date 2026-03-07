module ChatUpdatable
  extend ActiveSupport::Concern

  private

    def chat_update(record)
      message = params.dig(record.class.name.underscore, 'current_message')

      if message.blank?
        handle_blank_chat_message(record)
        return
      end

      @last_log = record.create_message(message: message, user: current_user)
      @chat_msg = record.chat_message_from_log(@last_log, current_user)
      after_chat_message_created(record)

      respond_to { |format| format.turbo_stream }
    end

    def handle_blank_chat_message(_record)
      head :unprocessable_entity
    end

    def after_chat_message_created(_record); end
end

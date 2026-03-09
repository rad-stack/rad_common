class ChatMessagesController < ApplicationController
  before_action :set_record

  def update
    @record.assign_attributes(permitted_params.except(:current_message))

    pre_result = @record.prepare_for_chat_update(params, current_user)
    if pre_result
      @reset_chat = pre_result[:reset]
      @chat_msg = pre_result[:chat_msg]
      respond_to { |format| format.turbo_stream }
      return
    end

    message = permitted_params[:current_message]

    if message.blank?
      @chat_msg = @record.handle_blank_chat_message(current_user)

      if @chat_msg
        respond_to { |format| format.turbo_stream }
      else
        head :unprocessable_entity
      end

      return
    end

    @last_log = @record.create_message(message: message, user: current_user)
    @chat_msg = @record.chat_message_from_log(@last_log, current_user)
    @record.after_chat_message_created(current_user)
    respond_to { |format| format.turbo_stream }
  end

  private

    def set_record
      klass = params[:chatable_type].safe_constantize
      raise ActiveRecord::RecordNotFound unless klass

      @record = klass.find(params[:id])
      authorize @record
    end

    def permitted_params
      params.require(@record.class.name.underscore).permit(*@record.chat_permitted_params)
    end
end

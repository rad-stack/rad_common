class DirectMessagesController < ApplicationController
  before_action :set_direct_message, only: %i[chat typing]

  def index
    authorize DirectMessage
    @direct_messages = policy_scope(DirectMessage).sorted.page(params[:page])
  end

  def chat; end

  def new
    @direct_message = DirectMessage.new
    authorize @direct_message
  end

  def create
    to_user = User.find(permitted_params[:to_user_id])
    @direct_message = DirectMessage.find_or_create_conversation(current_user, to_user)
    authorize @direct_message

    redirect_to chat_direct_message_path(@direct_message)
  end

  def typing
    if params[:stop]
      remove_typing_indicator
    else
      broadcast_typing_indicator
    end
    head :ok
  end

  private

    def broadcast_typing_indicator
      other_user = @direct_message.other_user(current_user)
      stream_name = "direct_message_#{@direct_message.id}_user_#{other_user.id}"
      typing_id = "typing-indicator-#{@direct_message.id}"

      Turbo::StreamsChannel.broadcast_remove_to(stream_name, target: typing_id)

      Turbo::StreamsChannel.broadcast_append_to(
        stream_name,
        target: @direct_message.chat_list_id,
        partial: 'direct_messages/typing_indicator',
        locals: { typing_id: typing_id, user_name: current_user.to_s }
      )

      Turbo::StreamsChannel.broadcast_action_to(stream_name, action: :scroll_bottom, target: 'scroll-container')
    end

    def remove_typing_indicator
      other_user = @direct_message.other_user(current_user)
      stream_name = "direct_message_#{@direct_message.id}_user_#{other_user.id}"
      Turbo::StreamsChannel.broadcast_remove_to(stream_name, target: "typing-indicator-#{@direct_message.id}")
    end

    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
      authorize @direct_message
    end

    def permitted_params
      params.require(:direct_message).permit(:to_user_id)
    end
end

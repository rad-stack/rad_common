class DirectMessagesController < ApplicationController
  before_action :set_direct_message, only: %i[show update chat]

  def index
    authorize DirectMessage
    @direct_messages = policy_scope(DirectMessage).sorted.page(params[:page])
  end

  def show; end

  def chat; end

  def new
    @direct_message = DirectMessage.new
    authorize @direct_message
  end

  def create
    to_user = User.find(permitted_params[:to_user_id])
    @direct_message = DirectMessage.find_or_create_conversation(current_user, to_user)
    authorize @direct_message

    redirect_to @direct_message
  end

  def update
    if permitted_params[:current_message].blank?
      redirect_to @direct_message, alert: 'Message cannot be blank.'
      return
    end

    @direct_message.log ||= []
    @direct_message.log << { role: 'user',
                             user_id: current_user.id,
                             content: permitted_params[:current_message],
                             chat_date: I18n.l(Time.current, format: :long) }
    @direct_message.save!
    broadcast_message_to_other_user

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @direct_message }
    end
  end

  private

    def broadcast_message_to_other_user
      other_user = @direct_message.other_user(current_user)
      stream_name = "direct_message_#{@direct_message.id}_user_#{other_user.id}"
      chat_list_id = "direct-message-#{@direct_message.id}-chat"
      last_log = @direct_message.log.last.symbolize_keys

      log_data = { direction: 'left',
                   user_name: current_user.to_s,
                   template: 'chat/message_left',
                   message: last_log[:content],
                   chat_date: last_log[:chat_date],
                   user: current_user }

      Turbo::StreamsChannel.broadcast_append_to(
        stream_name,
        target: chat_list_id,
        partial: log_data[:template],
        locals: log_data
      )

      Turbo::StreamsChannel.broadcast_action_to(
        stream_name,
        action: :scroll_bottom,
        target: 'scroll-container'
      )
    end

    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
      authorize @direct_message
    end

    def permitted_params
      params.require(:direct_message).permit(:to_user_id, :current_message)
    end
end

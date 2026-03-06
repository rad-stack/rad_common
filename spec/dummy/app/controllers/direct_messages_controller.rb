class DirectMessagesController < ApplicationController
  before_action :set_direct_message, only: %i[show update chat react]

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

  def react
    reaction_params = JSON.parse(request.body.read)
    message_index = reaction_params['message_index'].to_i
    emoji = reaction_params['emoji']

    log_entry = @direct_message.log[message_index]
    if log_entry.present?
      log_entry['reactions'] ||= {}
      log_entry['reactions'][emoji] ||= []

      if log_entry['reactions'][emoji].include?(current_user.id)
        log_entry['reactions'][emoji].delete(current_user.id)
        log_entry['reactions'].delete(emoji) if log_entry['reactions'][emoji].empty?
      else
        log_entry['reactions'][emoji] << current_user.id
      end

      log_entry['reactions'].delete_if { |_, ids| ids.empty? }
      @direct_message.save!
      broadcast_reaction_update(message_index)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "chat-reactions-#{message_index}",
          partial: 'chat/reactions',
          locals: { reactions: reaction_data(message_index), message_index: message_index }
        )
      end
    end
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

    def broadcast_reaction_update(message_index)
      other_user = @direct_message.other_user(current_user)
      stream_name = "direct_message_#{@direct_message.id}_user_#{other_user.id}"

      Turbo::StreamsChannel.broadcast_replace_to(
        stream_name,
        target: "chat-reactions-#{message_index}",
        partial: 'chat/reactions',
        locals: { reactions: reaction_data(message_index), message_index: message_index }
      )
    end

    def reaction_data(message_index)
      log_entry = @direct_message.log[message_index]
      (log_entry&.dig('reactions') || {}).transform_values { |ids| ids.map(&:to_i) }
    end

    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
      authorize @direct_message
    end

    def permitted_params
      params.require(:direct_message).permit(:to_user_id, :current_message)
    end
end

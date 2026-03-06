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

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @direct_message }
    end
  end

  private

    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
      authorize @direct_message
    end

    def permitted_params
      params.require(:direct_message).permit(:to_user_id, :current_message)
    end
end

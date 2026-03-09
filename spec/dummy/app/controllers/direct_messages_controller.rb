class DirectMessagesController < ApplicationController
  before_action :set_direct_message, only: %i[show]

  def index
    authorize DirectMessage
    @direct_messages = policy_scope(DirectMessage.for_user(current_user)).sorted.page(params[:page])
  end

  def show; end

  def new
    @direct_message = DirectMessage.new
    authorize @direct_message
  end

  def create
    recipient = User.find(params[:direct_message][:recipient_id])
    @direct_message = DirectMessage.find_or_create_conversation(current_user, recipient)
    authorize @direct_message

    redirect_to @direct_message
  end

  private

    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
      authorize @direct_message
    end
end

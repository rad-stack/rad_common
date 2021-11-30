class SystemMessagesController < ApplicationController
  before_action :set_system_message, only: %i[show]

  def show; end

  def new
    @system_message = SystemMessage.recent_or_new(current_user)
    authorize @system_message
  end

  def create
    @system_message = SystemMessage.new(permitted_params)
    @system_message.user = true_user
    authorize @system_message

    if @system_message.save
      @system_message.send!
      redirect_to "/rad_common/system_messages/#{@system_message.id}", notice: 'The message was successfully sent.'
    else
      render :new
    end
  end

  private

    def set_system_message
      @system_message = SystemMessage.find(params[:id])
      authorize @system_message
    end

    def permitted_params
      params.require(:system_message).permit(:send_to, :security_role_id, :message_type, :sms_message_body,
                                             :email_message_body)
    end
end

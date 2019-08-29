class SystemMessagesController < ApplicationController
  before_action :authenticate_user!, except: :twilio
  before_action :set_system_message, only: %i[show]

  ensure_authorization_performed except: :twilio

  authorize_actions_for SystemMessage, except: :twilio

  def show; end

  def new
    @system_message = SystemMessage.recent_or_new(current_user)
  end

  def create
    @system_message = SystemMessage.new(permitted_params)
    @system_message.user = current_user

    if @system_message.save
      @system_message.send!
      redirect_to "/rad_common/system_messages/#{@system_message.id}", notice: 'The message was successfully sent.'
    else
      render :new
    end
  end

  def twilio
    @language_code   = 'en'
    @header_message  = "Important message from #{Company.main.name}"
    @message         = params[:message]
    @repeat_message  = 'This message will now repeat.'
    @goodbye_message = 'Goodbye.'
  end

  private

    def set_system_message
      @system_message = SystemMessage.find(params[:id])
    end

    def permitted_params
      params.require(:system_message).permit(:message, :send_to)
    end
end

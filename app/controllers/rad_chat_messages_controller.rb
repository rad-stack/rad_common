class RadChatMessagesController < ApplicationController
  before_action :set_chattable

  def send_message
    @reset_chat = false

    if params['reset_chat'].present?
      reset_chat
    elsif params[:current_message].blank?
      handle_missing_message
    else
      handle_message
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

    def set_chattable
      klass = params[:chattable_type].constantize
      raise ArgumentError, "#{klass} does not include Chattable" unless klass.include?(Chattable)

      @chattable = klass.find(params[:chattable_id])
      authorize @chattable, :update?
    end

    def reset_chat
      @reset_chat = true
      @chattable.reset_chat!
    end

    def handle_missing_message
      @last_log = { 'role' => 'assistant', 'content' => 'Message is missing, please try again',
                    'chat_date' => ApplicationController.helpers.format_datetime(DateTime.current) }
      @chattable.handle_chat_message(nil, current_user)
    end

    def handle_message
      message = params[:current_message]
      @chattable.current_message = message
      @last_log = { 'role' => 'user', 'content' => message,
                    'chat_date' => ApplicationController.helpers.format_datetime(DateTime.current) }
      @chattable.handle_chat_message(message, current_user)
    end
end

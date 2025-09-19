class LLMChatsController < ApplicationController
  before_action :set_llm_chat, only: %i[update check_response show]

  def index
    authorize LLMChat
    @llm_chats = policy_scope(LLMChat.all).page(params[:page]).order(created_at: :desc)
  end

  def show; end

  def update
    @reset_chat = false

    if params['reset_chat'].present?
      reset_chat
    elsif permitted_params[:current_message].blank?
      missing_message
    elsif @llm_chat.context_object? && permitted_params[:contextable_id].blank?
      missing_user
    else
      handle_update
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def check_response
    respond_to do |format|
      format.html do
        if @llm_chat.completed? || @llm_chat.failed?
          logs = @llm_chat.log || []
          latest_assistant_message = logs.reverse.find { |msg| msg['role'] == 'assistant' }
          @bot_response = latest_assistant_message
        end
        render template: 'llm_chats/check_response'
      end

      format.json { render json: { status: @llm_chat.status } }
    end
  end

  private

    def set_llm_chat
      @llm_chat = LLMChat.find(params[:id])
      authorize @llm_chat
    end

    def permitted_params
      params.require(:llm_chat).permit(:user_id, :log, :context_id, :context_type, :current_message,
                                       :contextable_id, :contextable_type)
    end

    def reset_chat
      @reset_chat = true
      @llm_chat.update!(status: 'processing', current_message: nil, log: [])
    end

    def missing_message
      @last_log = LLM::PromptBuilder.build_assistant_message('Message is missing, please try again')
      @llm_chat.log ||= []
      @llm_chat.log << @last_log
      @llm_chat.save
    end

    def missing_user
      @last_log = LLM::PromptBuilder.build_assistant_message('User is missing, please try again')
      @llm_chat.log ||= []
      @llm_chat.log << @last_log
      @llm_chat.save
    end

    def handle_update
      @response_id = "#{@llm_chat.id}-#{Time.current.to_i}"
      @llm_chat.assign_attributes(permitted_params)
      @llm_chat.status = 'processing'
      @llm_chat.log ||= []
      @last_log = LLM::PromptBuilder.build_user_message(@llm_chat.current_message)

      ChatResponseJob.perform_later(@llm_chat.id, @llm_chat.current_message) if @llm_chat.save
    end
end

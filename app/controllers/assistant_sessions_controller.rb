class AssistantSessionsController < ApplicationController
  include ChatUpdatable

  before_action :set_assistant_session, only: %i[update check_response show]

  def index
    authorize AssistantSession
    @assistant_sessions = policy_scope(AssistantSession.sorted).page(params[:page]).order(created_at: :desc)
  end

  def show; end

  def update
    @reset_chat = false

    if params['reset_chat'].present?
      reset_chat
      respond_to { |format| format.turbo_stream }
    elsif @assistant_session.context_object? && permitted_params[:contextable_id].blank?
      missing_user
      respond_to { |format| format.turbo_stream }
    else
      @assistant_session.assign_attributes(permitted_params.except(:current_message))
      chat_update(@assistant_session)
    end
  end

  def check_response
    respond_to do |format|
      format.html do
        if @assistant_session.status_completed? || @assistant_session.status_failed?
          logs = @assistant_session.log || []
          latest_assistant_message = logs.reverse.find { |msg| msg['role'] == 'assistant' }
          @bot_response = latest_assistant_message
        end
        render template: 'assistant_sessions/check_response'
      end

      format.json { render json: { status: @assistant_session.status } }
    end
  end

  private

    def set_assistant_session
      @assistant_session = AssistantSession.find(params[:id])
      authorize @assistant_session
    end

    def permitted_params
      params.require(:assistant_session).permit(:user_id, :log, :context_id, :context_type, :current_message,
                                                :contextable_id, :contextable_type)
    end

    def reset_chat
      @reset_chat = true
      @assistant_session.update!(status: 'processing', current_message: nil, log: [])
    end

    def handle_blank_chat_message(_record)
      @last_log = LLM::PromptBuilder.build_assistant_message('Message is missing, please try again')
      @assistant_session.log ||= []
      @assistant_session.log << @last_log
      @assistant_session.save
      @chat_msg = @assistant_session.chat_message_from_log(@last_log, current_user)
      respond_to { |format| format.turbo_stream }
    end

    def missing_user
      @last_log = LLM::PromptBuilder.build_assistant_message('User is missing, please try again')
      @assistant_session.log ||= []
      @assistant_session.log << @last_log
      @assistant_session.save
      @chat_msg = @assistant_session.chat_message_from_log(@last_log, current_user)
    end

    def after_chat_message_created(record)
      @response_id = "#{record.id}-#{Time.current.to_i}"
    end
end

class AssistantSessionsController < ApplicationController
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
    elsif permitted_params[:current_message].blank?
      missing_message
    elsif @assistant_session.context_object? && permitted_params[:contextable_id].blank?
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
        if @assistant_session.completed? || @assistant_session.failed?
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

    def missing_message
      @last_log = LLM::PromptBuilder.build_assistant_message('Message is missing, please try again')
      @assistant_session.log ||= []
      @assistant_session.log << @last_log
      @assistant_session.save
    end

    def missing_user
      @last_log = LLM::PromptBuilder.build_assistant_message('User is missing, please try again')
      @assistant_session.log ||= []
      @assistant_session.log << @last_log
      @assistant_session.save
    end

    def handle_update
      @response_id = "#{@assistant_session.id}-#{Time.current.to_i}"
      @assistant_session.assign_attributes(permitted_params)
      @assistant_session.status = 'processing'
      @assistant_session.log ||= []
      @last_log = LLM::PromptBuilder.build_user_message(@assistant_session.current_message)
      return unless @assistant_session.save

      ChatResponseJob.perform_later(@assistant_session.id, @assistant_session.current_message)
    end
end

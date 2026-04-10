class AssistantSessionsController < ApplicationController
  before_action :set_assistant_session, only: %i[update show mentions]

  def index
    authorize AssistantSession
    @assistant_sessions = policy_scope(AssistantSession.sorted).page(params[:page]).order(created_at: :desc)
  end

  def show; end

  def mentions
    query = params[:q].to_s.strip
    type = params[:type].to_s

    results = if query.length >= 2
                @assistant_session.chat_instance.search_mentionables(query, type, current_user)
              else
                []
              end

    render json: results
  end

  def update
    @reset_chat = false

    if params['reset_chat'].present?
      reset_chat
    elsif permitted_params[:current_message].blank?
      missing_message
    else
      handle_update
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

    def set_assistant_session
      @assistant_session = AssistantSession.find(params[:id])
      authorize @assistant_session
    end

    def permitted_params
      params.require(:assistant_session).permit(:user_id, :log, :context_id, :context_type, :current_message)
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

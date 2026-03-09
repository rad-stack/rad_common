class AssistantSessionsController < ApplicationController
  before_action :set_assistant_session, only: %i[check_response show]

  def index
    authorize AssistantSession
    @assistant_sessions = policy_scope(AssistantSession.sorted).page(params[:page]).order(created_at: :desc)
  end

  def show; end

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
end

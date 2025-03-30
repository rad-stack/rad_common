module Api
  class AppActivitiesController < Api::BasicAppController
    before_action :set_last_audit

    def show
      render json: { last_activity_at: last_activity_at, last_user_name: last_user_name }, status: :ok
    end
  end

  private

    def set_last_audit
      @last_audit = Audited::Audit.order(id: :desc).limit(1).first
    end

    def last_activity_at
      @last_audit&.created_at
    end

    def last_user_name
      @last_audit&.user.to_s
    end
end

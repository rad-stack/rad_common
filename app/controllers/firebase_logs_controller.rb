class FirebaseLogsController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for User
  LOG_LIMIT = 100

  def index
    if params[:app_id].present?
      @app = FirebaseApp.find(params[:app_id])
    else
      @app = FirebaseApp.all.first
    end

    @limited_log_categories = limited_log_categories
    @firebase_logs = firebase_results
  end

  def destroy
    app_id = params[:app_id].to_i
    FirebaseLogDestroyJob.perform_later(app_id, params[:type], params[:id], current_user.id)
    flash[:info] = 'Firebase log destruction is in progress'
    redirect_to firebase_logs_path(app_id: app_id)
  end

  private

    def check_result_success(result)
      unless result.success?
        raise "#{result.body}"
      end
    end

    def limited_log_categories
      @app.categories.select { |category| more_results_exist?(category) }
    end

    def more_results_exist?(category)
      results = @app.client.get("logs/#{category}", orderBy: '"timestamp"', limitToLast: LOG_LIMIT + 1)
      results.body.count >= LOG_LIMIT + 1 if results.body
    end

    def firebase_results
      @app.categories.map do |category|
        result = @app.client.get("logs/#{category}", orderBy: '"timestamp"', limitToLast: LOG_LIMIT)
        check_result_success(result)
        [category, result.body]
      end
    end
end

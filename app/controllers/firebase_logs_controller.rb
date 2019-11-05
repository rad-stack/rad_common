class FirebaseLogsController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for User
  LOG_LIMIT = 100

  def index
    @app = FirebaseApp.new
    @limited_log_categories = limited_log_categories
    @firebase_logs = firebase_results
  end

  def destroy
    FirebaseLogDestroyJob.perform_later(params[:type], params[:id], current_user.id)
    flash[:info] = 'Firebase log destruction is in progress'
    redirect_to firebase_logs_path
  end

  private

    def check_result_success(result)
      raise result.body.to_s unless result.success?
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

class SMSDevLogsController < ApplicationController
  before_action :ensure_development!

  def index
    authorize :sms_dev_log
    skip_policy_scope
    @users_with_messages = SMSLogStore.users_with_messages
  end

  def show
    authorize :sms_dev_log
    @user_id = params[:id].to_i
    @messages = SMSLogStore.messages_for_user(@user_id)
    @user = User.find_by(id: @user_id)
    @user_name = @user&.to_s || @messages.first&.to_number || 'Unknown'
  end

  def clear
    authorize :sms_dev_log
    SMSLogStore.clear!
    redirect_to sms_dev_logs_path, notice: 'SMS log cleared.'
  end

  private

    def ensure_development!
      raise ActionController::RoutingError, 'Not Found' unless SMSLogStore.enabled?
    end
end

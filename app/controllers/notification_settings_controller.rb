class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for NotificationSetting

  def index
    notifications = Notifications::Notification.authorized(current_user)
    @notification_settings = []

    notifications.each do |notification|
      @notification_settings.push NotificationSetting.find_or_initialize_by(notification_type: notification,
                                                                            user_id: current_user.id)
    end
  end

  def create
    notification_type = permitted_params[:notification_type]

    notification_setting = NotificationSetting.find_or_initialize_by(notification_type: notification_type,
                                                                     user: current_user)

    notification_setting.enabled = permitted_params[:enabled]

    authorize_action_for notification_setting

    result = if notification_setting.save
               { notice: 'The setting was successfully saved.' }
             else
               { error: "The setting could not be saved: #{notification_setting.errors.full_messages.join(', ')}" }
             end

    redirect_to '/rad_common/notification_settings', result
  end

  private

    def permitted_params
      params.require(:notification_setting).permit(:notification_type, :enabled)
    end
end

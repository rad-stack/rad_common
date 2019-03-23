class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification_setting, only: %i[update]

  authorize_actions_for NotificationSetting

  def index
    notifications = Notifications::Notification.authorized(current_user)
    @notification_settings = []

    notifications.each do |notification|
      @notification_settings.push NotificationSetting.find_or_initialize_by(notification_type: notification)
    end
  end

  def create
    @notification_setting = NotificationSetting.new(permitted_params)
    @notification_setting.user = current_user

    result = if @notification_setting.save
               { notice: 'The setting was successfully saved.' }
             else
               { error: "The setting could not be saved: #{@notification_setting.errors.full_messages.join(', ')}"}
             end

    redirect_to notification_settings_path, result
  end

  def update
    result = if @notification_setting.update(permitted_params)
               { notice: 'The setting was successfully saved.' }
             else
               { error: "The setting could not be saved: #{@notification_setting.errors.full_messages.join(', ')}"}
             end

    redirect_to notification_settings_path, result
  end

  private

    def set_notification_setting
      @notification_setting = NotificationSetting.find(params[:id])
    end

    def permitted_params
      params.require(:notification_setting).permit(:notification_type, :enabled)
    end
end

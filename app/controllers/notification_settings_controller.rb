class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize NotificationSetting
    skip_policy_scope
  end

  def create
    notification_type_id = permitted_params[:notification_type_id]

    notification_setting = NotificationSetting.find_or_initialize_by(notification_type_id: notification_type_id,
                                                                     user_id: permitted_params[:user_id])

    notification_setting.enabled = permitted_params[:enabled]

    authorize notification_setting

    result = if notification_setting.save
               { notice: 'The setting was successfully saved.' }
             else
               { error: "The setting could not be saved: #{notification_setting.errors.full_messages.join(', ')}" }
             end

    redirect_back fallback_location: '/rad_common/notification_settings', flash: result
  end

  private

    def permitted_params
      params.require(:notification_setting).permit(:notification_type_id, :enabled, :user_id)
    end
end

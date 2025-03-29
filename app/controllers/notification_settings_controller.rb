class NotificationSettingsController < ApplicationController
  before_action :set_notification_type, only: :create

  def index
    authorize NotificationSetting
    skip_policy_scope
  end

  def create
    notification_setting = NotificationSetting.init_for_user(@notification_type, User.find(permitted_params[:user_id]))
    notification_setting.enabled = permitted_params[:enabled]
    notification_setting.email = permitted_params[:email] if @notification_type.email_enabled?
    notification_setting.feed = permitted_params[:feed] if @notification_type.feed_enabled?
    notification_setting.sms = permitted_params[:sms] if RadConfig.twilio_enabled? && @notification_type.sms_enabled?

    authorize notification_setting

    if notification_setting.save
      render partial: 'notification_settings/toggle_enabled',
             locals: { notification_setting: notification_setting,
                       can_update: true,
                       toast_success: 'The setting was successfully saved.' }
    else
      message = "The setting could not be saved: #{notification_setting.errors.full_messages.join(', ')}"

      render partial: 'notification_settings/toggle_enabled',
             locals: { notification_setting: notification_setting, can_update: true, toast_error: message }
    end
  end

  private

    def set_notification_type
      @notification_type = NotificationType.find_by(id: permitted_params[:notification_type_id])
      raise 'Invalid parameters' if @notification_type.blank?
    end

    def permitted_params
      params.require(:notification_setting).permit(:notification_type_id, :enabled, :user_id, :email, :feed, :sms)
    end
end

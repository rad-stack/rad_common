class NotificationSettingsController < ApplicationController
  def index
    authorize NotificationSetting
    skip_policy_scope
  end

  def create
    notification_type = NotificationType.find_by(id: permitted_params[:notification_type_id])

    if notification_type.blank?
      skip_authorization
      render json: { error: 'Invalid parameters' }, status: :unprocessable_entity
      return
    end

    notification_setting = NotificationSetting.init_for_user(notification_type, User.find(permitted_params[:user_id]))
    notification_setting.enabled = permitted_params[:enabled]
    notification_setting.email = permitted_params[:email] if notification_type.email_enabled?
    notification_setting.feed = permitted_params[:feed] if notification_type.feed_enabled?
    notification_setting.sms = permitted_params[:sms] if RadConfig.twilio_enabled? && notification_type.sms_enabled?

    authorize notification_setting

    if notification_setting.save
      render json: { status: 'The setting was successfully saved.' }, status: :ok
    else
      render json: { error:
                         "The setting could not be saved: #{notification_setting.errors.full_messages.join(', ')}" },
             status: :unprocessable_entity
    end
  end

  private

    def permitted_params
      params.require(:notification_setting).permit(:notification_type_id, :enabled, :user_id, :email, :feed, :sms)
    end
end

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
    notification_setting.email = permitted_params[:email]
    notification_setting.feed = permitted_params[:feed]
    notification_setting.sms = permitted_params[:sms] if RadicalTwilio.twilio_enabled?

    authorize notification_setting

    respond_to do |format|
      format.html do
        result = if notification_setting.save
                   { notice: 'The setting was successfully saved.' }
                 else
                   { error: "The setting could not be saved: #{notification_setting.errors.full_messages.join(', ')}" }
                 end

        redirect_back fallback_location: '/rad_common/notification_settings', flash: result
      end
      format.json do
        if notification_setting.save
          render json: { status: 'The setting was successfully saved.' }, status: :ok
        else
          render json: { error:
                          "The setting could not be saved: #{notification_setting.errors.full_messages.join(', ')}" },
                 status: :unprocessable_entity
        end
      end
    end
  end

  private

    def permitted_params
      params.require(:notification_setting).permit(:notification_type_id, :enabled, :user_id, :email, :feed, :sms)
    end
end

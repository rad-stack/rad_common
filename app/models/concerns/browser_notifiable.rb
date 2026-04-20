module BrowserNotifiable
  extend ActiveSupport::Concern

  def notify_browser!(user_id, notification)
    return unless RadConfig.browser_notifications_enabled? && browser_enabled? && browser_enabled_for_user?(user_id)

    WebPushNotificationJob.perform_later(notification_id: notification.id, user_id: user_id)
  end

  private

    def browser_enabled_for_user?(user_id)
      setting = notification_settings.find_by(user_id: user_id)
      setting.blank? || (setting.enabled? && setting.feed?)
    end
end

module BrowserNotifiable
  extend ActiveSupport::Concern

  def notify_browser!(user_id, notification)
    unless RadConfig.browser_notifications_enabled?
      Rails.logger.debug('[BrowserNotifiable] Skipping - browser notifications not enabled globally')
      return
    end

    unless browser_enabled?
      Rails.logger.debug do
        "[BrowserNotifiable] Skipping - browser not enabled for notification type #{self.class.name}"
      end
      return
    end

    unless browser_enabled_for_user?(user_id)
      Rails.logger.debug { "[BrowserNotifiable] Skipping - browser not enabled for user #{user_id}" }
      return
    end

    broadcast_toast(user_id)
    schedule_web_push(user_id, notification)
  end

  private

    def browser_enabled_for_user?(user_id)
      setting = notification_settings.find_by(user_id: user_id)
      return true if setting.blank?
      return false unless setting.enabled?

      setting.feed?
    end

    def broadcast_toast(user_id)
      Turbo::StreamsChannel.broadcast_render_to(
        "notifications_#{user_id}",
        partial: 'layouts/toast_stream',
        locals: { header: toast_header, message: toast_content, user_id: user_id, subject_url: subject_url }
      )
    rescue Redis::BaseError => e
      Rails.logger.error("[BrowserNotifiable] Turbo broadcast failed for user #{user_id}: #{e.message}")
    end

    def schedule_web_push(user_id, notification)
      WebPushNotificationJob.perform_later(notification_id: notification.id, user_id: user_id)
    end
end

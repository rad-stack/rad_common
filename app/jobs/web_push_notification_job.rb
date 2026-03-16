class WebPushNotificationJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: :polynomially_longer, attempts: 5
  discard_on ActiveRecord::RecordNotFound

  def perform(notification_id:, user_id:)
    notification = Notification.find(notification_id)
    user = User.find(user_id)

    unless notification.unread?
      Rails.logger.info("[WebPush] Skipping notification #{notification_id} - already read")
      return
    end

    unless browser_notifications_enabled_for?(user, notification)
      Rails.logger.info(
        "[WebPush] Skipping notification #{notification_id} - browser notifications not enabled for user #{user_id}"
      )
      return
    end

    deliver_to_subscriptions(user, notification)
  end

  private

    def browser_notifications_enabled_for?(user, notification)
      return false unless RadConfig.browser_notifications_enabled?

      setting = notification.notification_type.notification_settings.find_by(user: user)
      return true if setting.blank?
      return false unless setting.enabled?

      setting.feed?
    end

    def deliver_to_subscriptions(user, notification)
      subscriptions = user.push_subscriptions.to_a
      return if subscriptions.empty?

      notification_type = notification.notification_type
      # Restore the payload from the notification's stored record
      notification_type.payload = notification.record

      success_count = 0
      failure_count = 0

      subscriptions.each do |subscription|
        result = subscription.push_message(
          title: notification_type.toast_header,
          body: notification_type.toast_content,
          url: notification_type.subject_url,
          tag: "notification-#{notification.id}"
        )
        result ? success_count += 1 : failure_count += 1
      rescue StandardError => e
        Rails.logger.error("[WebPush] Error delivering to subscription #{subscription.id}: #{e.message}")
        failure_count += 1
      end

      Rails.logger.info(
        "[WebPush] Notification #{notification.id} to user #{user.id}: " \
        "#{success_count} sent, #{failure_count} failed/removed"
      )
    end
end

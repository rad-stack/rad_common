class WebPushNotificationJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: :polynomially_longer, attempts: 5
  discard_on ActiveRecord::RecordNotFound

  def perform(notification_id:, user_id:)
    notification = Notification.find(notification_id)
    user = User.find(user_id)
    return unless notification.unread? && browser_notifications_enabled_for?(user, notification)

    deliver_to_subscriptions(user, notification)
  end

  private

    def browser_notifications_enabled_for?(user, notification)
      return false unless RadConfig.browser_notifications_enabled?

      setting = notification.notification_type.notification_settings.find_by(user: user)
      setting.blank? || (setting.enabled? && setting.feed?)
    end

    def deliver_to_subscriptions(user, notification)
      subscriptions = user.push_subscriptions.to_a
      return if subscriptions.empty?

      notification_type = notification.notification_type
      notification_type.payload = notification.record

      subscriptions.each do |subscription|
        subscription.push_message(
          title: notification_type.push_title,
          body: notification_type.push_body,
          url: notification_type.subject_url,
          tag: "notification-#{notification.id}"
        )
      end
    end
end

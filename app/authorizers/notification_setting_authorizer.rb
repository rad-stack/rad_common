class NotificationSettingAuthorizer < ApplicationAuthorizer
  # class rules
  def self.creatable_by?(user)
    Notifications::Notification.authorized(user).count.positive?
  end

  def self.readable_by?(user)
    Notifications::Notification.authorized(user).count.positive?
  end

  def self.updatable_by?(user)
    Notifications::Notification.authorized(user).count.positive?
  end

  def self.deletable_by?(_user)
    false
  end
end

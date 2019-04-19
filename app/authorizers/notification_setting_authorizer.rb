class NotificationSettingAuthorizer < ApplicationAuthorizer
  # class rules
  def self.creatable_by?(user)
    user.permission?(:admin) || Notifications::Notification.authorized(user).count.positive?
  end

  def self.readable_by?(user)
    user.permission?(:admin) || Notifications::Notification.authorized(user).count.positive?
  end

  def self.updatable_by?(_user)
    false
  end

  def self.deletable_by?(_user)
    false
  end

  # instance rules
  def creatable_by?(user)
    return true if resource.notification_type.blank?

    user.permission?(:admin) || resource.notification.new.permitted_users.include?(resource.user)
  end
end

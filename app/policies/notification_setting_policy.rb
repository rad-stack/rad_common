class NotificationSettingPolicy < ApplicationPolicy
  def create?
    # class rules
    return false unless user.permission?(:admin) || NotificationType.authorized(user).count.positive?
    return true unless record.is_a?(NotificationSetting)

    # instance rules
    return true if record.notification_type.blank?

    user.permission?(:admin) || record.notification_type.permitted_users.include?(record.user)
  end

  def show?
    user.permission?(:admin) || NotificationType.authorized(user).count.positive?
  end

  def update?
    false
  end

  alias destroy? update?
end

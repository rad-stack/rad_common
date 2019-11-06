class NotificationSettingPolicy < ApplicationPolicy
  def create?
    return false unless user.permission?(:admin) || NotificationType.authorized(user).count.positive?
    return true if record.is_a?(Class)
    return true if record.notification_type.blank?

    user.permission?(:admin) || record.notification_type.permitted_users.include?(record.user)
  end

  def show?
    user.permission?(:admin) || NotificationType.authorized(user).count.positive?
  end

  def update?
    false
  end

  def destroy?
    false
  end
end

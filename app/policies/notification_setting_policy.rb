class NotificationSettingPolicy < ApplicationPolicy
  def create?
    # class rules
    return false unless user.permission?(:admin) || notification_types?
    return true unless record.is_a?(NotificationSetting)

    # instance rules
    return true if record.notification_type.blank?

    user.permission?(:admin) || record.notification_type.permitted_users.include?(record.user)
  end

  def show?
    user.permission?(:admin) || notification_types?
  end

  def update?
    false
  end

  alias index? show?
  alias destroy? update?

  private

    def notification_types?
      Pundit.policy_scope!(user, NotificationType).count.positive?
    end
end

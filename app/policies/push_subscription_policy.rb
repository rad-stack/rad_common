class PushSubscriptionPolicy < ApplicationPolicy
  def vapid_public_key?
    RadConfig.browser_notifications_enabled?
  end

  def create?
    RadConfig.browser_notifications_enabled?
  end

  def destroy?
    record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end
end

class NotificationPolicy < ApplicationPolicy
  def index?
    Pundit.policy_scope!(user, Notification).exists?
  end

  def create?
    false
  end

  alias show? create?
  alias update? create?
  alias destroy? update?

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end

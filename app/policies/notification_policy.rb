class NotificationPolicy < ApplicationPolicy
  def index?
    Pundit.policy_scope!(user, Notification).count.positive?
  end

  def create?
    false
  end

  def show?
    create?
  end

  def update?
    create?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end

class NotificationTypePolicy < ApplicationPolicy
  def create?
    false
  end

  def destroy?
    false
  end
end

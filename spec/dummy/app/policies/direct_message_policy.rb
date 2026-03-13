class DirectMessagePolicy < ApplicationPolicy
  def show?
    record.participant?(user)
  end

  def create?
    user.active?
  end

  def new?
    create?
  end

  def update?
    record.participant?(user)
  end

  def index?
    user.active?
  end

  class Scope < Scope
    def resolve
      scope.for_user(user)
    end
  end
end

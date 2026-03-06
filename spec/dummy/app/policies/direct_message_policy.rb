class DirectMessagePolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end

  def update?
    show?
  end

  def chat?
    show?
  end

  def react?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(from_user: user).or(scope.where(to_user: user))
    end
  end
end

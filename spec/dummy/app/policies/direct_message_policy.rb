class DirectMessagePolicy < ApplicationPolicy
  def show?
    record.from_user == user || record.to_user == user
  end

  def update?
    show?
  end

  def chat?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(from_user: user).or(scope.where(to_user: user))
    end
  end
end

class SavedSearchFilterPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.user == user
  end

  def update?
    false
  end

  def new?
    update?
  end

  def show?
    update?
  end

  def index?
    update?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end

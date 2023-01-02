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

  alias new? update?
  alias show? update?
  alias index? update?

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end

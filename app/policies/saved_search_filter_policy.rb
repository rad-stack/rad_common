class SavedSearchFilterPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.search_setting.user == user
  end

  def update?
    false
  end

  alias new? update?
  alias show? update?
  alias index? update?

  class Scope < Scope
    def resolve
      scope.joins(:search_setting).where(search_settings: { user: user })
    end
  end
end

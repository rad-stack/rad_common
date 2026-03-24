class SearchPreferencePolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user == record.user
  end
end

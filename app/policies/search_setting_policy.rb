class SearchSettingPolicy < ApplicationPolicy
  def update?
    record.user == user
  end
end

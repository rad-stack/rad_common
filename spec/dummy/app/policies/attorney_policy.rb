class AttorneyPolicy < ApplicationPolicy
  def index?
    user.permission? :read_attorney
  end

  alias show? index?
end

class AttorneyPolicy < ApplicationPolicy
  def index?
    user.permission? :read_attorney
  end

  def show?
    index?
  end
end

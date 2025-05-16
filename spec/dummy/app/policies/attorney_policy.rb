class AttorneyPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end
end

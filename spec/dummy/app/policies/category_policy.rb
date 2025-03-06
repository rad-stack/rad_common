class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def create?
    index?
  end
end

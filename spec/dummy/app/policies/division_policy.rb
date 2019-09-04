class DivisionPolicy < ApplicationPolicy
  def index?
    user.permission?(:read_division)
  end

  def show?
    index?
  end

  def create?
    user.permission?(:create_division)
  end

  def update?
    user.permission?(:update_division)
  end

  def destroy?
    user.permission?(:delete_division)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

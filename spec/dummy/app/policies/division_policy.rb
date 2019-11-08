class DivisionPolicy < ApplicationPolicy
  def show?
    user.permission?(:read_division)
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

  alias_method :index?, :show?
end

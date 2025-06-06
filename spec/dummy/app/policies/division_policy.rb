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

  def index?
    show?
  end

  def audit?
    destroy?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(owner_id: user.id)
      end
    end
  end
end

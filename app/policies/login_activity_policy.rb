class LoginActivityPolicy < ApplicationPolicy
  def create?
    false
  end

  def show?
    create?
  end

  def destroy?
    create?
  end

  def update?
    create?
  end
end

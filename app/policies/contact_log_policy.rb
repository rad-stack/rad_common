class ContactLogPolicy < ApplicationPolicy
  def create?
    false
  end

  def destroy?
    create?
  end

  def update?
    create?
  end
end

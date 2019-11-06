class SecurityRolePolicy < ApplicationPolicy
  def permission?
    show?
  end
end

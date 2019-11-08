class SecurityRolePolicy < ApplicationPolicy
  alias_method :permission? , :show?
end

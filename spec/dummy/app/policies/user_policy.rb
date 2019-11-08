class UserPolicy < ApplicationPolicy
  alias_method :audit_search?, :audit?
  alias_method :audit_by?, :audit?
  alias_method :resend_invitation?, :create?
  alias_method :confirm?, :update?
  alias_method :reset_authy?, :update?
end

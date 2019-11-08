class UserPolicy < ApplicationPolicy
  alias audit_search? audit?
  alias audit_by? audit?
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?
end

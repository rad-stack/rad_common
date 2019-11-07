class UserPolicy < ApplicationPolicy
  def audit_search?
    audit?
  end

  alias audit_by? audit?
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?
end

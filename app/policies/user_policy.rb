class UserPolicy < ApplicationPolicy
  alias audit_search? audit?
  alias audit_by? audit?
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?

  def invite_user?
    user.permission?(:invite_user) || user.permission?(:admin)
  end
end

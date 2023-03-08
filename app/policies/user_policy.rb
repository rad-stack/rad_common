class UserPolicy < ApplicationPolicy
  def index?
    user.internal?
  end

  def create?
    user.permission?(:manage_user)
  end

  def update_security_roles?
    return true if user.permission?(:admin)

    record != user
  end

  alias show? create?
  alias update? create?
  alias destroy? create?
  alias resend_invitation? create?
  alias confirm? update?
  alias test_email? update?
  alias test_sms? update?
  alias reactivate? update?
  alias setup_totp? update?
  alias register_totp? update?

  def impersonate?
    return false unless user.permission?(:admin) && RadicalConfig.impersonate?

    user != record
  end
end

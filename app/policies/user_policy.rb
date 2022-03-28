class UserPolicy < ApplicationPolicy
  def index?
    user.internal?
  end

  def create?
    user.permission?(:manage_user)
  end

  alias show? create?
  alias update? create?
  alias destroy? create?
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?
  alias test_email? update?
  alias test_sms? update?

  def impersonate?
    return false unless user.permission?(:admin) && RadicalConfig.impersonate?

    user != record
  end
end

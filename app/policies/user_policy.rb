class UserPolicy < ApplicationPolicy
  def index?
    user.internal?
  end

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

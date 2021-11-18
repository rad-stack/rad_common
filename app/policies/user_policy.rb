class UserPolicy < ApplicationPolicy
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?
  alias test_email? update?
  alias test_sms? update?

  def impersonate?
    return false unless user.permission?(:admin) && impersonate_enabled?

    user != record
  end

  private

    def impersonate_enabled?
      Rails.configuration.rad_common.impersonate
    end
end

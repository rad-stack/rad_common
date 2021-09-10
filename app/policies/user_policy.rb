class UserPolicy < ApplicationPolicy
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?
  alias test_email? update?
  alias test_sms? update?
end

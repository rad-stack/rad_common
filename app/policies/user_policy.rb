class UserPolicy < ApplicationPolicy
  alias resend_invitation? create?
  alias confirm? update?
  alias reset_authy? update?
end

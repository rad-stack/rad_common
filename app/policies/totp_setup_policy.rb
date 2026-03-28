class TotpSetupPolicy < ApplicationPolicy
  def show?
    user.otp_required_for_login?
  end

  def new?
    show?
  end

  def create?
    show?
  end

  def destroy?
    show? && user.twilio_totp_factor_sid.present?
  end
end

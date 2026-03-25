class RadUserPolicy < ApplicationPolicy
  def index?
    user.internal?
  end

  def create?
    user.permission?(:manage_user)
  end

  def update_security_roles?
    return true if user.permission?(:admin)
    return false unless user.permission?(:manage_user) && user.internal?

    record != user
  end

  def show?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create? && user.internal?
  end

  def resend_invitation?
    create?
  end

  def confirm?
    update? && user.internal?
  end

  def test_email?
    update?
  end

  def test_sms?
    update?
  end

  def reactivate?
    update? && user.internal?
  end

  def update_timezone?
    user == record && UserTimezone.new(record).wrong_timezone?
  end

  def ignore_timezone?
    update_timezone?
  end

  def impersonate?
    return false unless user.permission?(:admin) && RadConfig.impersonate?

    record.active? && user != record
  end

  def allow_email_change?
    record.new_record? || !record.admin?
  end

  def permitted_attributes
    base_attributes + two_factor_attributes + RadConfig.additional_user_params!
  end

  private

    def base_attributes
      items = %i[user_status_id first_name last_name mobile_phone last_activity_at password password_confirmation
                 external timezone avatar language]

      items.push(:email) if allow_email_change?

      items
    end

    def two_factor_attributes
      return [:otp_required_for_login] if RadConfig.two_factor_auth_enabled? && !RadConfig.two_factor_auth_all_users?

      []
    end
end

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
    base_attributes + twilio_verify_attributes + RadConfig.additional_user_params!
  end

  private

    def base_attributes
      items = %i[user_status_id first_name last_name mobile_phone last_activity_at password password_confirmation
                 external timezone avatar language]

      items.push(:email) if allow_email_change?

      items
    end

    def twilio_verify_attributes
      return [:twilio_verify_enabled] if RadConfig.twilio_verify_enabled? && !RadConfig.twilio_verify_all_users?

      []
    end
end

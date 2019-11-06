class UserPolicy < ApplicationPolicy
  def audit_search?
    audit?
  end

  def audit_by?
    audit?
  end

  def resend_invitation?
    create?
  end

  def confirm?
    update?
  end

  def reset_authy?
    update?
  end
end

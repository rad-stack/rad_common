class SecurityRolesUser < ApplicationRecord
  belongs_to :security_role
  belongs_to :user

  validate :validate_user

  after_create :touch_user
  after_destroy :touch_user

  audited associated_with: :user

  def to_s
    "#{security_role} - #{user}"
  end

  def touch_user
    user.touch
  end

  private

  def validate_user
    return if user.blank?

    errors.add(:user, 'is not valid when external') if user.external?
  end
end

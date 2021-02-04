class UserSecurityRole < ApplicationRecord
  belongs_to :security_role
  belongs_to :user

  validate :validate_external

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

    def validate_external
      return unless security_role.present? && user.present?

      errors.add(:security_role, "isn't applicable for this user") unless security_role.external == user.external
    end
end

class SecurityRolesUser < ApplicationRecord
  belongs_to :security_role
  belongs_to :user
  after_create :touch_user
  after_destroy :touch_user

  audited associated_with: :user

  def touch_user
    user.touch
  end
end

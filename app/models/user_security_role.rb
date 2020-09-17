class UserSecurityRole < ApplicationRecord
  belongs_to :security_role
  belongs_to :user

  after_create :touch_user
  after_destroy :touch_user

  audited associated_with: :user

  def to_s
    "#{security_role} - #{user}"
  end

  def touch_user
    user.touch
  end
end

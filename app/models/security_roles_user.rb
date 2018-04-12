class SecurityRolesUser < ApplicationRecord
  belongs_to :security_role
  belongs_to :user, touch: true

  audited associated_with: :user
end

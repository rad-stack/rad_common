class NotificationSecurityRole < ApplicationRecord
  include Authority::Abilities

  belongs_to :security_role
end

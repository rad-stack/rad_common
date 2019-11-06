class NotificationSecurityRole < ApplicationRecord
  include Authority::Abilities

  belongs_to :notification_type
  belongs_to :security_role

  audited
end

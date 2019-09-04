class NotificationSecurityRole < ApplicationRecord
  belongs_to :notification_type
  belongs_to :security_role

  audited
end

class NotificationType < ApplicationRecord
  include Authority::Abilities

  has_many :notification_security_roles, dependent: :destroy
  has_many :security_roles, through: :notification_security_roles, dependent: :destroy
  has_many :notification_settings, dependent: :destroy

  alias_attribute :to_s, :description

  scope :by_name, -> { order(:name) }

  def description
    name.gsub('Notifications::', '').underscore.titleize.gsub(' Notification', '')
  end

  def self.authorized(user)
    where_clause = 'id IN (SELECT notification_type_id FROM notification_security_roles WHERE security_role_id IN '\
                         '(SELECT security_role_id FROM security_roles_users WHERE user_id = ?) )'

    NotificationType.where(where_clause, user.id)
  end

  def permitted_users
    where_clause = 'users.id IN (SELECT user_id FROM security_roles_users WHERE security_role_id IN '\
                   '(SELECT security_role_id FROM notification_security_roles WHERE notification_type_id = ?))'

    User.active.where(where_clause, id)
  end

  def self.seed_items
    items = %w[Notifications::NewUserSignedUpNotification
               Notifications::UserWasApprovedNotification
               Notifications::UserAcceptsInvitationNotification
               Notifications::GlobalValidityNotification]

    items.each { |item| NotificationType.create! name: item }
  end

  def notify_list(fatal)
    users = permitted_users
    users = users.where.not(id: NotificationSetting.where(notification_type: self, enabled: false).pluck(:user_id))

    raise 'no users to notify' if fatal && users.count.zero?

    users
  end

  def notify_user_ids
    notify_list(true).pluck(:id)
  end

  def self.notify_user_ids
    notification_type = NotificationType.find_by(name: to_s)
    notification_type = NotificationType.create! name: to_s if notification_type.blank?

    if notification_type.notification_security_roles.count.zero?
      notification_type.notification_security_roles.create! security_role: SecurityRole.admin_role
    end

    notification_type.notify_user_ids
  end
end

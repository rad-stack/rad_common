class NotificationType < ApplicationRecord
  include Authority::Abilities

  has_many :notification_security_roles, dependent: :destroy
  has_many :security_roles, through: :notification_security_roles, dependent: :destroy
  has_many :notification_settings, dependent: :destroy

  enum auth_mode: %i[security_roles absolute_user]
  alias_attribute :to_s, :description

  scope :by_name, -> { order(:name) }

  validate :validate_auth, on: :update

  def description
    name.gsub('Notifications::', '').underscore.titleize.gsub(' Notification', '')
  end

  def self.authorized(user)
    where_clause = 'notification_types.auth_mode = 1 OR '\
                   '(id IN (SELECT notification_type_id FROM notification_security_roles WHERE security_role_id IN '\
                   '(SELECT security_role_id FROM security_roles_users WHERE user_id = ?) ))'

    NotificationType.where(where_clause, user.id)
  end

  def permitted_users
    users = User.active

    if security_roles?
      where_clause = 'users.id IN (SELECT user_id FROM security_roles_users WHERE security_role_id IN '\
                     '(SELECT security_role_id FROM notification_security_roles WHERE notification_type_id = ?))'

      users = users.where(where_clause, id)
    end

    users
  end

  def self.seed_items
    items = %w[Notifications::NewUserSignedUpNotification
               Notifications::UserWasApprovedNotification
               Notifications::UserAcceptsInvitationNotification
               Notifications::GlobalValidityNotification]

    items.each { |item| NotificationType.create! name: item }
  end

  def notify_list(fatal)
    raise 'invalid auth mode' if absolute_user?

    users = permitted_users
    users = users.where.not(id: NotificationSetting.where(notification_type: self, enabled: false).pluck(:user_id))

    raise 'no users to notify' if fatal && users.count.zero?

    users
  end

  def notify_user_ids
    notify_list(true).pluck(:id)
  end

  def self.notify_user_ids
    notification_type = set_notification_type
    raise 'invalid auth mode' if notification_type.absolute_user?

    if notification_type.security_roles? && notification_type.notification_security_roles.count.zero?
      notification_type.notification_security_roles.create! security_role: SecurityRole.admin_role
    end

    notification_type.notify_user_ids
  end

  def self.absolute_user?(user)
    raise 'absolute user must be active' unless user.active

    notification_type = set_notification_type
    raise 'invalid auth mode' if notification_type.security_roles?

    setting = notification_type.notification_settings.find_by(user_id: user.id)
    return true if setting.blank?

    setting.enabled
  end

  def self.set_notification_type
    notification_type = NotificationType.find_by(name: to_s)
    notification_type = NotificationType.create! name: to_s if notification_type.blank?
    notification_type
  end

  private

    def validate_auth
      errors.add(:auth_mode, 'invalid with security roles') if absolute_user? && security_roles.count.positive?
      errors.add(:auth_mode, 'invalid without security roles') if security_roles? && security_roles.count.zero?
    end
end

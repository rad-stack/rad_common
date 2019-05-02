module RadSecurityRole
  extend ActiveSupport::Concern

  included do
    include Authority::Abilities

    has_many :security_roles_users
    has_many :users, through: :security_roles_users, dependent: :destroy
    has_many :notification_security_roles, dependent: :destroy

    scope :by_name, -> { order(:name) }
    alias_attribute :to_s, :name

    validate :validate_standard_permissions

    audited
  end

  def permission_attributes
    filtered_attributes = attributes.dup

    filtered_attributes.each do |key, _value|
      unless SecurityRole.permission_fields.include?(key)
        filtered_attributes.delete(key)
      end
    end

    filtered_attributes
  end

  module ClassMethods
    def seed_items
      seed_admin
      seed_user
    end

    def seed_admin(group_name = 'Admin')
      group = get_group(group_name)
      seed_all group
      group.save!

      group.notification_security_roles.create! notification_type: 'Notifications::NewUserSignedUpNotification'
      group.notification_security_roles.create! notification_type: 'Notifications::UserWasApprovedNotification'
      group.notification_security_roles.create! notification_type: 'Notifications::UserAcceptsInvitationNotification'
      group.notification_security_roles.create! notification_type: 'Notifications::GlobalValidityNotification'
    end

    def seed_all(group)
      permission_fields.each { |item| group.send(item + '=', true) }
    end

    def seed_user
      group = get_group('User')
      group.save!
    end

    def permission_fields
      (SecurityRole.attribute_names - %w[id name created_at updated_at]).sort
    end

    def get_group(name)
      group = SecurityRole.find_or_initialize_by(name: name)

      # init all perms to false
      SecurityRole.permission_fields.each do |field|
        group.send(field + '=', false)
      end

      group
    end
  end

  private

    def validate_standard_permissions
      return unless admin?

      SecurityRole.permission_fields.each do |field|
        unless public_send(field)
          errors.add(:admin, 'requires all permissions to be true')
          break
        end
      end
    end
end

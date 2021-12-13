module RadSecurityRole
  ADMIN_ROLE_NAME = 'Admin'.freeze

  extend ActiveSupport::Concern

  included do
    has_many :user_security_roles, dependent: :restrict_with_error
    has_many :users, through: :user_security_roles, dependent: :destroy
    has_many :notification_security_roles, dependent: :destroy
    has_many :system_messages, dependent: :destroy

    scope :by_name, -> { order(:name) }
    scope :internal, -> { where(external: false) }
    scope :external, -> { where(external: true) }

    alias_attribute :to_s, :name

    validate :validate_standard_permissions

    strip_attributes
    audited
  end

  def permission_attributes
    filtered_attributes = attributes.dup

    filtered_attributes.each do |key, _value|
      filtered_attributes.delete(key) unless SecurityRole.permission_fields.include?(key)
    end

    filtered_attributes
  end

  module ClassMethods
    def resolve_roles(role_ids)
      if role_ids
        ids = role_ids.reject { |id| id == '' }.map(&:to_i)
        SecurityRole.where(id: ids)
      else
        []
      end
    end

    def admin_role
      role = SecurityRole.find_by(admin: true)
      raise 'missing admin security role' if role.blank?

      role
    end

    def seed_items
      seed_admin
      seed_user

      return true unless RadicalConfig.external_users?

      seed_portal_admin
      seed_portal_user
    end

    def seed_admin(group_name = ADMIN_ROLE_NAME)
      group = get_group(group_name)
      seed_all group
      group.save!

      NotificationType.all.find_each do |notification_type|
        group.notification_security_roles.create! notification_type: notification_type
      end

      true
    end

    def seed_all(group)
      permission_fields.each { |item| group.send("#{item}=", true) }
    end

    def seed_user
      group = get_group('User')
      group.save!
    end

    def seed_portal_admin
      group = get_group('Portal Admin')
      group.external = true
      group.save!
    end

    def seed_portal_user
      group = get_group('Portal User')
      group.external = true
      group.save!
    end

    def permission_fields
      (SecurityRole.attribute_names - %w[id name created_at updated_at external]).sort
    end

    def get_group(name)
      group = SecurityRole.find_or_initialize_by(name: name)

      # init all perms to false
      SecurityRole.permission_fields.each do |field|
        group.send("#{field}=", false)
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

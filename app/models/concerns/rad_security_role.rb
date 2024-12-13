module RadSecurityRole
  extend ActiveSupport::Concern

  included do
    has_many :user_security_roles, dependent: :restrict_with_error
    has_many :users, through: :user_security_roles, dependent: :destroy
    has_many :notification_security_roles, dependent: :destroy
    has_many :system_messages, dependent: :destroy

    scope :sorted, -> { order(:name) }
    scope :internal, -> { where(external: false) }
    scope :external, -> { where(external: true) }
    scope :allow_sign_up, -> { where(allow_sign_up: true) }
    scope :allow_invite, -> { where(allow_invite: true) }

    alias_attribute :to_s, :name

    validate :validate_standard_permissions
    validate :validate_rules
    validate :validate_external_security_role

    strip_attributes
    audited
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

    def unused
      SecurityRole.sorted.select { |item| item.users.active.count.zero? }
    end
  end

  private

    def validate_standard_permissions
      return unless admin?

      RadPermission.all.each do |field|
        unless public_send(field)
          errors.add(:admin, 'requires all permissions to be true')
          break
        end
      end
    end

    def validate_rules
      errors.add(:allow_invite, 'is not applicable') if allow_invite? && RadConfig.disable_invite?
      errors.add(:allow_sign_up, 'is not applicable') if allow_sign_up? && RadConfig.disable_sign_up?
    end

    def validate_external_security_role
      return unless external? && !RadConfig.external_users?

      errors.add(:external, 'cannot be true when external users setting is off')
    end
end

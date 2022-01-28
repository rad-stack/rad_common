module RadSecurityRole
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

    def permission_fields
      (SecurityRole.attribute_names - %w[id name created_at updated_at external]).sort
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

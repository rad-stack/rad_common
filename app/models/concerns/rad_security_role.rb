module RadSecurityRole
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :users
    scope :by_name, -> { order(:name) }
    alias_attribute :to_s, :name

    validate :validate_standard_permissions
    validate :validate_permission_uniqueness

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

    def validate_permission_uniqueness
      groups = SecurityRole.where.not(id: id)

      groups.each do |group|
        errors.add(:base, 'Group permissions cannot match another group') if permission_attributes == group.permission_attributes
      end
    end
end

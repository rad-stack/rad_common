class SecurityRole < ApplicationRecord
  include Authority::Abilities

  has_and_belongs_to_many :users

  scope :by_name, -> { order(:name) }

  alias_attribute :to_s, :name

  validate :validate_standard_permissions

  audited

  def self.permission_fields
    (SecurityRole.attribute_names - %w[id name created_at updated_at]).sort
  end

  def self.default_user
    SecurityRole.find_by(name: 'User')
  end

  def self.seed_items
    seed_admin
    seed_manager
    seed_user
  end

  class << self
    private def get_group(name)
      group = SecurityRole.find_or_initialize_by(name: name)

      # init all perms to false
      SecurityRole.permission_fields.each do |field|
        group.send(field + '=', false)
      end

      group
    end

    private def seed_admin
      group = get_group('Admin')
      seed_all group
      group.save!
    end

    private def seed_user
      group = get_group('User')
      group.read_division = true
      group.save!
    end

    private def seed_manager
      group = get_group('User')
      group.create_division = true
      group.read_division = true
      group.update_division = true
      group.save!
    end

    private def seed_all(group)
      group.admin = true
      group.read_audit = true
      group.read_user = true
      group.create_division = true
      group.read_division = true
      group.update_division = true
      group.delete_division = true
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

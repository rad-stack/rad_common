class SecurityGroup < ApplicationRecord
  include Authority::Abilities

  has_many :users
  scope :by_name, -> { order(:name) }

  alias_attribute :to_s, :name
  validate :validate_standard_permissions

  audited

  def self.permission_fields
    (SecurityGroup.attribute_names - %w[id name created_at updated_at]).sort
  end

  def self.default_user
    SecurityGroup.first
  end

  private

    def validate_standard_permissions
      if admin?
        SecurityGroup.permission_fields.each do |field|
          if public_send(field) != true
            errors.add(:admin, 'requires all permissions to be true')
            break
          end
        end
      end
    end

end

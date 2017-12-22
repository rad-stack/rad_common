class Company < ApplicationRecord
  include Authority::Abilities
  include RadCompany

  scope :by_id, -> { order(:id) }
  alias_attribute :to_s, :name

  validate :validate_only_one, on: :create
  validates_with PhoneNumberValidator

  def self.main
    Company.first
  end

  def full_address
    address = "#{self.address_1}"
    address = "#{address}, #{self.address_2}" unless self.address_2.present?
    address = "#{address}, #{self.city}, #{self.state} #{self.zipcode}"
    address
  end

  private

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count > 0
    end
end

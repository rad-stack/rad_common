class Company < ApplicationRecord
  include Authority::Abilities
  include RadCompany

  alias_attribute :to_s, :name

  validate :validate_only_one, on: :create
  validates_with PhoneNumberValidator

  audited

  def self.main
    Company.first
  end

  def full_address
    address = address_1.to_s
    address = "#{address}, #{address_2}" if address_2.present?
    address = "#{address}, #{city}, #{state} #{zipcode}"
    address
  end

  private

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count > 0
    end
end

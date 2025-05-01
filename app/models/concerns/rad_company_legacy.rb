module RadCompanyLegacy
  extend ActiveSupport::Concern

  included do
    include ContactableLegacy

    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    validates_with EmailAddressValidator, fields: %i[email]
    validates_with PhoneNumberValidator
    validate :validate_only_one, on: :create
    validate :validate_domains

    before_validation :clean_domain_spaces

    strip_attributes
    audited
  end

  module ClassMethods
    def main
      Company.first
    end
  end

  def global_validity_ran!
    update! validity_checked_at: Time.current
  end

  private

    def clean_domain_spaces
      return if valid_user_domains.blank?

      self.valid_user_domains = valid_user_domains.map(&:strip).compact_blank
    end

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.exists?
    end

    def validate_domains
      return if valid_user_domains.nil?

      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.none?
    end
end

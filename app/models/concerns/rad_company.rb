module RadCompany
  extend ActiveSupport::Concern

  included do
    include HasAddress

    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    SKIP_SCHEMA_VALIDATION_COLUMNS = [:valid_user_domains].freeze

    validates_with EmailAddressValidator, fields: %i[email]
    validates_with PhoneNumberValidator
    validate :validate_only_one, on: :create
    validate :validate_domains

    audited
  end

  module ClassMethods
    def main
      Company.first
    end
  end

  def valid_user_domains_entry=(value)
    if value
      items = value.split(',')
      stripped = items.map(&:strip)
      self.valid_user_domains = stripped.reject(&:blank?)
    else
      self.valid_user_domains = '{}'
    end
  end

  def valid_user_domains_entry
    valid_user_domains&.join(', ')
  end

  def global_validity_ran!
    update! validity_checked_at: Time.current
  end

  private

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count.positive?
    end

    def validate_domains
      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.count.zero?
    end
end

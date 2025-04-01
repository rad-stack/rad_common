module RadCompany
  extend ActiveSupport::Concern

  included do
    include Contactable

    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    validates_with EmailAddressValidator, fields: %i[email]
    validates_with PhoneNumberValidator
    validate :validate_only_one, on: :create
    validate :validate_domains

    before_validation :clean_domain_spaces

    has_one_attached :app_logo
    has_one_attached :fav_icon

    strip_attributes
    audited except: %i[quickbooks_token quickbooks_refresh_token github_token]
  end

  module ClassMethods
    def main
      Company.first
    end
  end

  def global_validity_ran!
    update! validity_checked_at: Time.current
  end

  def pdf_app_logo
    return  Rails.root.join("app/assets/images/app_logo.png") unless app_logo.attached?

    url = ApplicationController.helpers.company_logo(self)
    URI.parse(url).open
  end

  private

    def clean_domain_spaces
      return if valid_user_domains.blank?

      self.valid_user_domains = valid_user_domains.map(&:strip).compact_blank
    end

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count.positive?
    end

    def validate_domains
      return if valid_user_domains.nil?

      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.count.zero?
    end
end

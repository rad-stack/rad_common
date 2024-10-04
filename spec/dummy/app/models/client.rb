class Client < ApplicationRecord
  include RadClient

  alias_attribute :to_s, :name

  scope :sorted, -> { order(:name) }

  SKIP_SCHEMA_VALIDATION_COLUMNS = [:valid_user_domains].freeze

  before_validation :clean_domain_spaces

  strip_attributes
  audited

  def clean_domain_spaces
    return if valid_user_domains.blank?

    self.valid_user_domains = valid_user_domains.map(&:strip).compact_blank
  end
end

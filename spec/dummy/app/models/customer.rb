class Customer < ApplicationRecord
  include RadCustomer

  alias_attribute :to_s, :name

  scope :by_name, -> { order(:name) }

  SKIP_SCHEMA_VALIDATION_COLUMNS = [:valid_user_domains].freeze

  strip_attributes
  audited
end

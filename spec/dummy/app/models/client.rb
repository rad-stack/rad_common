class Client < ApplicationRecord
  include RadClient

  alias_attribute :to_s, :name

  scope :sorted, -> { order(:name) }

  SKIP_SCHEMA_VALIDATION_COLUMNS = [:valid_user_domains].freeze

  strip_attributes
  audited
end

class Client < ApplicationRecord
  has_many :user_clients, dependent: :restrict_with_error
  has_many :users, through: :user_clients

  alias_attribute :to_s, :name

  scope :active, -> { all } # TODO: impelement active
  scope :by_name, -> { order(:name) }

  SKIP_SCHEMA_VALIDATION_COLUMNS = [:valid_user_domains].freeze

  strip_attributes
  audited
end

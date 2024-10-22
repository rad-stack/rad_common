class Client < ApplicationRecord
  include RadClient

  schema_validation_options do
    column :valid_user_domains, skip: true
  end

  alias_attribute :to_s, :name

  scope :sorted, -> { order(:name) }

  strip_attributes
  audited
end

class SavedSearchFilter < ApplicationRecord
  belongs_to :user

  scope :sorted, -> { order(:name) }

  alias_attribute :to_s, :name

  strip_attributes
  audited associated_with: :user
end

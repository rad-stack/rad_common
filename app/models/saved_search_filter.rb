class SavedSearchFilter < ApplicationRecord
  belongs_to :search_setting

  scope :sorted, -> { order(:name) }
  scope :for_search_class, ->(search) { joins(:search_setting).where(search_settings: { search_class: search }) }

  alias_attribute :to_s, :name

  strip_attributes
  audited associated_with: :search_setting
end

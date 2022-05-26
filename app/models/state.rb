class State < ApplicationRecord
  alias_attribute :to_s, :name

  scope :sorted, -> { order(:code) }

  audited
  strip_attributes
end

class Category < ApplicationRecord
  audited
  strip_attributes

  has_many :divisions, dependent: :restrict_with_error

  alias_attribute :to_s, :name

  audited
  strip_attributes
end

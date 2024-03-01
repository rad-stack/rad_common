class Category < ApplicationRecord
  has_many :divisions, dependent: :restrict_with_error

  alias_attribute :to_s, :name

  audited
  strip_attributes
end

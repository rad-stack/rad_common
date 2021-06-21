class Status < ApplicationRecord
  alias_attribute :to_s, :name

  strip_attributes
  audited
end

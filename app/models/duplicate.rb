class Duplicate < ApplicationRecord
  belongs_to :duplicatable, polymorphic: true
end

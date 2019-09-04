class Status < ApplicationRecord
  audited

  alias_attribute :to_s, :name

end

class ApplicationRecord < ActiveRecord::Base
  include SchemaValidations

  self.abstract_class = true
end

class ApplicationRecord < ActiveRecord::Base
  include SchemaValidations

  validate :load_schema_validations
  self.abstract_class = true
end

class ApplicationRecord < ActiveRecord::Base
  include SchemaValidations

  class_attribute :schema_validations_loaded

  before_validation :load_schema_validations
  self.abstract_class = true
end

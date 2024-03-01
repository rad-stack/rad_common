class ApplicationRecord < ActiveRecord::Base
  include SchemaValidations

  class_attribute :schema_validations_loaded
  attr_accessor :running_global_validity

  class_attribute :seeding
  delegate :seeding, to: :class

  validate :load_schema_validations
  self.abstract_class = true
end

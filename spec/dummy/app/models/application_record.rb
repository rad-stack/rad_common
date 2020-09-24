class ApplicationRecord < ActiveRecord::Base
  include SchemaValidations
  attr_accessor :running_global_validity

  self.abstract_class = true
end

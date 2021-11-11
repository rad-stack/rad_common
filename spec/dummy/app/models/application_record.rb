class ApplicationRecord < ActiveRecord::Base
  include SchemaValidations

  self.abstract_class = true
  class_attribute :suppress_notifications
end

class Category < ApplicationRecord
  has_many :divisions, dependent: :restrict_with_error

  schema_validation_options do
    index :index_categories_on_name, message: 'taken by another category'
    column :name, message: 'cannot be left blank'
  end

  alias_attribute :to_s, :name

  audited
  strip_attributes
end

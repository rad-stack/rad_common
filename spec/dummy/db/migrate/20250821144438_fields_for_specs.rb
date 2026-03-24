class FieldsForSpecs < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :business_type, :string
    add_index :clients, %i[name business_type], unique: true, nulls_not_distinct: true
  end
end

class AddTagsToDivisions < ActiveRecord::Migration[7.2]
  def change
    add_column :divisions, :tags, :string, array: true, default: [], null: false
  end
end

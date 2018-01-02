class SuperSearchDefault < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :super_search_default, :boolean, null: false, default: false
  end
end

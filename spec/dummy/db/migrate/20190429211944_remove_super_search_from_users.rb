class RemoveSuperSearchFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :super_search_default
  end
end

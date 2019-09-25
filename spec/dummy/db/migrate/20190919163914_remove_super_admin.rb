class RemoveSuperAdmin < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :super_admin
  end
end

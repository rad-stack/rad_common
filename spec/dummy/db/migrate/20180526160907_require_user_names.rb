class RequireUserNames < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :first_name, :string, limit: 255, null: false
    change_column :users, :last_name, :string, limit: 255, null: false
  end
end

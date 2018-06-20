class AddUsersApproved < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :approved, :boolean, null: false, default: false
  end
end

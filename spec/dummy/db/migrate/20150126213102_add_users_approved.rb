class AddUsersApproved < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, null: false, default: false
  end
end

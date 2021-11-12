class RemoveFirebase < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :firebase_id
  end
end

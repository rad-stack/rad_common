class UserFirebaseId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firebase_id, :string
  end
end

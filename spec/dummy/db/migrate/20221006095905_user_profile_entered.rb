class UserProfileEntered < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_entered, :boolean, null: false, default: false
    add_column :users, :birth_date, :date
  end
end

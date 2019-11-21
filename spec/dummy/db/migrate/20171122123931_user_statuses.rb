class UserStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_statuses do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: false
      t.boolean :validate_email, null: false, default: true

      t.timestamps
    end

    add_index :user_statuses, :name, unique: true
    add_reference :users, :user_status, foreign_key: true
    change_column :users, :user_status_id, :integer, null: false
  end
end

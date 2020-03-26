class DeviseSecurityUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :old_passwords do |t|
      t.string :encrypted_password, null: false
      t.string :password_archivable_type, null: false
      t.integer :password_archivable_id, null: false
      t.string :password_salt # Optional. bcrypt stores the salt in the encrypted password field so this column may not be necessary.
      t.datetime :created_at
    end

    add_index :old_passwords, [:password_archivable_type, :password_archivable_id], name: 'index_password_archivable'

    add_column :users, :password_changed_at, :datetime
    add_column :users, :last_activity_at, :datetime
    add_column :users, :expired_at, :datetime

    add_index :users, :password_changed_at
    add_index :users, :last_activity_at
    add_index :users, :expired_at
  end
end

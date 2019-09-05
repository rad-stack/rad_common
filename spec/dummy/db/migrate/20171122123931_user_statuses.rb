class UserStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_statuses do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: false
      t.boolean :validate_email, null: false, default: true

      t.timestamps
    end

    add_index :user_statuses, :name, unique: true

    UserStatus.seed_items
    active = UserStatus.find_by(name: 'Active')
    inactive = UserStatus.find_by(name: 'Inactive')

    add_reference :users, :user_status, foreign_key: true

    # User.where.not(approved: true).update_all(user_status_id: inactive.id)
    # User.where(approved: true).update_all(user_status_id: active.id)

    change_column :users, :user_status_id, :integer, null: false
    # remove_column :users, :approved
  end
end

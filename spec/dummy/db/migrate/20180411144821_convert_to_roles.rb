class ConvertToRoles < ActiveRecord::Migration[5.0]
  def change
    rename_table :security_groups, :security_roles

    create_table :security_roles_users do |t|
      t.references :security_role, null: false
      t.references :user, null: false

      t.timestamps
    end

    add_foreign_key :security_roles_users, :security_roles
    add_foreign_key :security_roles_users, :users

    add_index :security_roles_users, %i[security_role_id user_id], unique: true

    remove_column :users, :security_group_id
  end
end

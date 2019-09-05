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

    ActiveRecord::Base.connection.execute 'INSERT INTO security_roles_users (security_role_id, user_id, created_at, updated_at) SELECT security_group_id, id, updated_at, updated_at FROM users'

    remove_column :users, :security_group_id
    # remove_column :users, :admin

    # add more permissions for dummy app
    rename_column :security_roles, :create_parent, :create_division
    add_column :security_roles, :read_division, :boolean, null: false, default: false
    add_column :security_roles, :update_division, :boolean, null: false, default: false
    add_column :security_roles, :delete_division, :boolean, null: false, default: false
  end
end

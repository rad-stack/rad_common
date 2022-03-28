class ManageUsersPerm < ActiveRecord::Migration[6.1]
  def change
    add_column :security_roles, :manage_users, :boolean, null: false, default: false
    return if SecurityRole.count.zero?

    execute 'UPDATE security_roles SET manage_users = TRUE WHERE admin = TRUE;'
  end
end

class ManageUsersPerm < ActiveRecord::Migration[6.1]
  def change
    add_column :security_roles, :manage_user, :boolean, null: false, default: false
    return if SecurityRole.none?

    execute 'UPDATE security_roles SET manage_user = TRUE WHERE admin = TRUE;'
  end
end

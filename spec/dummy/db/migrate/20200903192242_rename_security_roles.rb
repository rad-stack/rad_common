class RenameSecurityRoles < ActiveRecord::Migration[6.0]
  def change
    rename_table :security_roles_users, :user_security_roles
  end
end

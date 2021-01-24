class ExternalSecurityRoles < ActiveRecord::Migration[6.0]
  def change
    add_column :security_roles, :external, :boolean, null: false, default: false
  end
end

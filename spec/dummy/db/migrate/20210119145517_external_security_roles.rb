class ExternalSecurityRoles < ActiveRecord::Migration[6.0]
  def change
    add_column :security_roles, :external, :boolean, null: false, default: false

    # execute <<-SQL
    #   UPDATE security_roles
    #   SET external = TRUE
    #   WHERE name = 'Account Admin' OR name = 'Account Approver' OR name = 'Account User';
    # SQL
  end
end

class SignUpRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :security_roles, :allow_sign_up, :boolean, null: false, default: false
  end
end

class ReadAttorneyPermission < ActiveRecord::Migration[7.0]
  def change
    add_column :security_roles, :read_attorney, :boolean, null: false, default: false
  end
end

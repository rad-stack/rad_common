class ReadAttorneyPermission < ActiveRecord::Migration[7.2]
  def change
    add_column :security_roles, :read_attorney, :boolean, null: false, default: false
  end
end

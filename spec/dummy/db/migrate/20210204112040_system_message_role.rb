class SystemMessageRole < ActiveRecord::Migration[6.0]
  def change
    add_column :system_messages, :security_role_id, :integer
    add_index :system_messages, :security_role_id
    add_foreign_key :system_messages, :security_roles
  end
end

class AddToSecurityGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :security_groups, :create_parent, :boolean, null: false, default: false
  end
end

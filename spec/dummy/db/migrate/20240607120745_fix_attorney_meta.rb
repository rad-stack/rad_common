class FixAttorneyMeta < ActiveRecord::Migration[7.0]
  def change
    add_column :attorneys, :address_metadata, :jsonb
    remove_column :attorneys, :bypass_address_validation
    remove_column :attorneys, :address_problems
    remove_column :attorneys, :address_changes
    # rename_column :security_roles, :create_parent, :create_division
    # add_column :security_roles, :read_division, :boolean, null: false, default: false
    # add_column :security_roles, :update_division, :boolean, null: false, default: false
    # add_column :security_roles, :delete_division, :boolean, null: false, default: false
  end
end

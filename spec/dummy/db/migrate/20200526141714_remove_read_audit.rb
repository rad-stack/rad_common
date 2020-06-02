class RemoveReadAudit < ActiveRecord::Migration[6.0]
  def change
    remove_column :security_roles, :read_audit
    # add_column :users, :filter_defaults, :jsonb
  end
end

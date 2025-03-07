class RemoveLegacyAuditedChanges < ActiveRecord::Migration[6.1]
  def change
    remove_column :audits, :legacy_audited_changes, :text
  end
end

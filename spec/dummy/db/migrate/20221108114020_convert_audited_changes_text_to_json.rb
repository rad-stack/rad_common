class ConvertAuditedChangesTextToJson < ActiveRecord::Migration[6.1]
  def change
    rename_column :audits, :audited_changes, :legacy_audited_changes
    rename_column :audits, :new_audited_changes, :audited_changes
  end
end

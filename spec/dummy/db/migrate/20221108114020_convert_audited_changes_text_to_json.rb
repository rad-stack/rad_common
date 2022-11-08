class ConvertAuditedChangesTextToJson < ActiveRecord::Migration[6.1]
  def change
    remove_column :audits, :audited_changes, :text
    rename_column :audits, :new_audited_changes, :audited_changes
  end
end

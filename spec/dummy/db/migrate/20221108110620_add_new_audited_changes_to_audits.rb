class AddNewAuditedChangesToAudits < ActiveRecord::Migration[6.1]
  def change
    add_column :audits, :new_audited_changes, :jsonb
  end
end

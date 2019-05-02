class TightenAudits < ActiveRecord::Migration[5.2]
  def change
    change_column_null :audits, :auditable_type, false
    change_column_null :audits, :auditable_id, false
    change_column_null :audits, :created_at, false
  end
end

class FixJsonbFieldStandards < ActiveRecord::Migration[7.2]
  def change
    change_column_null :companies, :address_metadata, false, '{}'
    change_column_null :audits, :audited_changes, false, '{}'
    change_column_null :assistant_sessions, :log, false, '[]'

    change_column_default :companies, :address_metadata, {}
    change_column_default :audits, :audited_changes, {}
    change_column_default :assistant_sessions, :log, []
  end
end

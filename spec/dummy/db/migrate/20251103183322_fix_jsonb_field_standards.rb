class FixJsonbFieldStandards < ActiveRecord::Migration[7.2]
  def change
    change_column_null :attorneys, :address_metadata, false, default: {}
    change_column_null :companies, :address_metadata, false, default: {}
    change_column_null :users, :filter_defaults, false, default: {}
    change_column_null :audits, :audited_changes, false, default: {}

    change_column_default :attorneys, :address_metadata, {}
    change_column_default :companies, :address_metadata, {}
    change_column_default :users, :filter_defaults, {}
    change_column_default :audits, :audited_changes, {}
  end
end

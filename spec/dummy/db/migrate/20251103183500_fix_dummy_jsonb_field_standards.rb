class FixDummyJsonbFieldStandards < ActiveRecord::Migration[7.2]
  def change
    change_column_null :attorneys, :address_metadata, false, default: {}
    change_column_default :attorneys, :address_metadata, {}
  end
end

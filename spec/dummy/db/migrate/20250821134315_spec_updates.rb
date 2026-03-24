class SpecUpdates < ActiveRecord::Migration[7.2]
  def change
    change_column_null :attorneys, :first_name, true
    change_column_null :attorneys, :last_name, true
  end
end

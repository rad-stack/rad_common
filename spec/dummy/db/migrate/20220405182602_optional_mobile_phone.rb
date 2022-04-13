class OptionalMobilePhone < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :mobile_phone, true
  end
end

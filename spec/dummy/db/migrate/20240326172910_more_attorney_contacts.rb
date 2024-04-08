class MoreAttorneyContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :attorneys, :mobile_phone, :string
    change_column_null :attorneys, :phone_number, true
  end
end

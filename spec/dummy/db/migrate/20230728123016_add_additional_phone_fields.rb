class AddAdditionalPhoneFields < ActiveRecord::Migration[7.0]
  def change
    add_column :attorneys, :phone_number_2, :string
    add_column :attorneys, :mobile_phone, :string
  end
end

class AddUniqIndex < ActiveRecord::Migration[7.2]
  def change
    add_index :attorneys, [:first_name, :last_name, :mobile_phone], unique: true
  end
end

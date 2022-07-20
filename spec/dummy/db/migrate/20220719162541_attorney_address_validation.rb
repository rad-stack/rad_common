class AttorneyAddressValidation < ActiveRecord::Migration[6.1]
  def change
    add_column :attorneys, :bypass_address_validation, :boolean, null: false, default: false
    add_column :attorneys, :address_problems, :text
  end
end

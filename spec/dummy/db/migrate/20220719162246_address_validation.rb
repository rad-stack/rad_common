class AddressValidation < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :bypass_address_validation, :boolean, null: false, default: false
    add_column :companies, :address_problems, :text
    add_column :companies, :lob_requests_made, :integer, null: false, default: 0
  end
end

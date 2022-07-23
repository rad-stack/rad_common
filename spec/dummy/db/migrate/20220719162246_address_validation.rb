class AddressValidation < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :bypass_address_validation, :boolean, null: false, default: false
    add_column :companies, :address_problems, :boolean, null: false, default: false
    add_column :companies, :address_changes, :jsonb

    add_column :companies, :address_requests_made, :integer, null: false, default: 0

    # add these 3 fields to any additional tables that require address validations
    # add_column :foobars, :bypass_address_validation, :boolean, null: false, default: false
    # add_column :foobars, :address_problems, :boolean, null: false, default: false
    # add_column :foobars, :address_changes, :jsonb
  end
end

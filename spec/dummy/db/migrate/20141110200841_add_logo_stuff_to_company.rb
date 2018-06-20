class AddLogoStuffToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :company_logo_includes_name, :boolean, null: false, default: false
    add_column :companies, :app_logo_includes_name, :boolean, null: false, default: false
  end
end

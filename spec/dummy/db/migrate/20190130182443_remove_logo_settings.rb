class RemoveLogoSettings < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :company_logo_includes_name
    remove_column :companies, :app_logo_includes_name
  end
end

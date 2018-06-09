class CompanyValidDomains < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :valid_user_domains, :text, default: '{}', array: true
  end
end

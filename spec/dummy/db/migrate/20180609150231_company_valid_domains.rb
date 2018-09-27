class CompanyValidDomains < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :valid_user_domains, :text, default: '{}', array: true

    # modify this migration and set this to your actual domains
    ActiveRecord::Base.connection.execute "UPDATE companies SET valid_user_domains = '{example.com}'"
  end
end

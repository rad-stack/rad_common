class CompanyValidityCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :validity_checked_at, :datetime
  end
end

class CompanyValidityCheck < ActiveRecord::Migration
  def change
    add_column :companies, :validity_checked_at, :datetime
  end
end

class DivisionEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :divisions, :invoice_email, :string
  end
end

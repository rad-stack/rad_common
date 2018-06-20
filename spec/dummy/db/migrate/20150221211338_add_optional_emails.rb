class AddOptionalEmails < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :optional_emails, :boolean, null: false, default: true
  end
end

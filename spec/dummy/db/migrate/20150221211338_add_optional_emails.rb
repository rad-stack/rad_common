class AddOptionalEmails < ActiveRecord::Migration
  def change
    add_column :users, :optional_emails, :boolean, null: false, default: true
  end
end

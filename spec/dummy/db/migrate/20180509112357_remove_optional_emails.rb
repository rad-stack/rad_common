class RemoveOptionalEmails < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :optional_emails
  end
end

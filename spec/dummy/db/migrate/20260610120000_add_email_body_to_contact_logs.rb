class AddEmailBodyToContactLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :contact_logs, :email_body, :string, limit: 1000
  end
end

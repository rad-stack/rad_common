class ContactLogSendgridStuff < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_log_recipients, :email_status, :integer
  end
end

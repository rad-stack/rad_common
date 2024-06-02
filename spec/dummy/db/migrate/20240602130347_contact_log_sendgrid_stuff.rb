class ContactLogSendgridStuff < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_log_recipients, :email_status, :integer
    rename_column :contact_log_recipients, :sms_success, :success
  end
end

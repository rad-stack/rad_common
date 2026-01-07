class AddFaxContactLogFields < ActiveRecord::Migration[7.2]
  def change
    add_column :contact_logs, :fax_message_id, :string
    add_column :contact_logs, :fax_error_message, :string
    rename_column :contact_logs, :sms_log_type, :direction
    add_column :contact_log_recipients, :fax_status, :integer
  end
end

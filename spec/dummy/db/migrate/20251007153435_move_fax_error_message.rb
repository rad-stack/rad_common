class MoveFaxErrorMessage < ActiveRecord::Migration[7.2]
  def change
    remove_column :contact_logs, :fax_error_message
    add_column :contact_log_recipients, :fax_error_message, :string
  end
end

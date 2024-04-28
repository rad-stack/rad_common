class ContactLogContent < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_logs, :content, :string

    if ContactLog.exists?
      execute <<-SQL
        UPDATE contact_logs SET content = message WHERE service_type = 0;
        UPDATE contact_logs SET content = subject WHERE service_type = 1;
      SQL
    end

    change_column_null :contact_logs, :content, false
    remove_column :contact_logs, :subject
    remove_column :contact_logs, :message
  end
end

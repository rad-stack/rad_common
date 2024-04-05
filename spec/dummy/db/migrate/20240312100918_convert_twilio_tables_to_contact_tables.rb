class ConvertTwilioTablesToContactTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :twilio_logs, :contact_logs
    rename_table :twilio_log_attachments, :contact_log_attachments

    create_table :contact_log_recipients do |t|
      t.references :contact_log, null: false, foreign_key: true
      t.references :to_user, foreign_key: { to_table: :users }
      t.string :email
      t.string :phone_number
      t.integer :email_type
      t.integer :service_status, default: 0, null: false

      t.timestamps
    end

    add_column :contact_logs, :from_email, :string
    add_column :contact_logs, :reply_to, :string
    add_column :contact_logs, :subject, :string
    add_column :contact_logs, :service_type, :integer, default: 0, null: false

    add_reference :contact_logs, :record, polymorphic: true, index: true

    add_index :contact_logs, :service_type

    change_column_null :contact_logs, :from_number, true
    change_column_null :contact_logs, :to_number, true

    rename_column :contact_logs, :twilio_status, :service_status

    rename_column :contact_log_attachments, :twilio_log_id, :contact_log_id
    rename_column :contact_log_attachments, :twilio_url, :service_url

    if ContactLog.exists?
      ContactLog.in_batches(of: 1000) do |logs|
        contact_log_recipients = logs.map do |log|
          {
            contact_log_id: log.id,
            service_status: log.service_status,
            phone_number: log.to_number,
            to_user_id: log.to_user_id,
            created_at: Time.now,
            updated_at: Time.now
          }
        end
        ContactLogRecipient.insert_all(contact_log_recipients)
      end
    end

    remove_column :contact_logs, :to_number, :string
    remove_column :contact_logs, :to_user_id, :bigint
    remove_column :contact_logs, :service_status, :integer
  end
end

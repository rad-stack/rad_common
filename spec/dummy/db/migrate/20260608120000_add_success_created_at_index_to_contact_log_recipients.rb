class AddSuccessCreatedAtIndexToContactLogRecipients < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_index :contact_log_recipients, %i[success created_at],
              algorithm: :concurrently,
              if_not_exists: true
  end
end

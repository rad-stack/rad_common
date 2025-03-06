class RemoveContactLogAttachments < ActiveRecord::Migration[7.0]
  def change
    drop_table :contact_log_attachments
  end
end

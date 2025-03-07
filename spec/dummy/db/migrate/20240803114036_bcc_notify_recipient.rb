class BCCNotifyRecipient < ActiveRecord::Migration[7.0]
  def change
    add_column :notification_types, :bcc_recipient, :string
  end
end

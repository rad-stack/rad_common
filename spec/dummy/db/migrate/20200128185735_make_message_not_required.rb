class MakeMessageNotRequired < ActiveRecord::Migration[6.0]
  def change
    change_column_null :system_messages, :message, true
    rename_column :system_messages, :message, :sms_message_body
  end
end

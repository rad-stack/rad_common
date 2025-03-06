class PersistSMSFalsePositive < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_log_recipients, :sms_false_positive, :boolean, null: false, default: false
  end
end

class MoreContactLogFixes < ActiveRecord::Migration[7.0]
  def change
    remove_column :contact_log_recipients, :bounce_classification
    remove_column :contact_log_recipients, :sendgrid_type
    remove_column :contact_log_recipients, :sendgrid_event
    return if ContactLogRecipient.none?

    ContactLogRecipient.sms_assumed_failed.update_all sms_status: :failed
  end
end

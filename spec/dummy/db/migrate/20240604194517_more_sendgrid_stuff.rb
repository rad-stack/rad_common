class MoreSendgridStuff < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_log_recipients, :sendgrid_event, :string
    add_column :contact_log_recipients, :sendgrid_type, :string
    add_column :contact_log_recipients, :bounce_classification, :string
    add_column :contact_log_recipients, :sendgrid_reason, :string
    add_column :contact_log_recipients, :notify_on_fail, :boolean, null: false, default: true
    return if NotificationType.none?

    execute <<~SQL
      UPDATE notification_types 
      SET type = 'Notifications::OutgoingContactFailedNotification' 
      WHERE type = 'Notifications::SendgridEmailStatusNotification'
    SQL
  end
end

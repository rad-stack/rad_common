class DivisionMailer < NotificationMailer
  def division_updated(notification_type, recipients, division)
    @division = division
    @contact_log_record = division
    send_notification_mail notification_type, recipients, 'Division Updated'
  end
end

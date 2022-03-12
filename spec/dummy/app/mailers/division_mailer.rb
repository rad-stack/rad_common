class DivisionMailer < NotificationMailer
  def division_updated(recipients, division)
    @division = division
    send_notification_mail recipients, 'Division Updated'
  end
end

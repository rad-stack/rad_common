class DivisionMailer < NotificationMailer
  def division_updated(recipients, division)
    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @division = division

    mail(to: to_address, subject: 'Division Updated')
  end
end

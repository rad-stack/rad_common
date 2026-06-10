class EmailBodyTestMailer < RadMailer
  def message_with_body(recipient, subject, body)
    @contact_log_email_body = body
    @message = body

    mail to: recipient,
         subject: subject,
         template_path: 'rad_mailer',
         template_name: 'simple_message'
  end
end

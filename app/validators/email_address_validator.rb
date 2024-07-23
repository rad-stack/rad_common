class EmailAddressValidator < ActiveModel::Validator
  def validate(record)
    return if record.blank?

    options[:fields].each do |field|
      next if record.send(field).blank?

      email_value = record.send(field).downcase
      email_value.downcase!
      record.send("#{field}=", email_value)

      unless valid_email?(email_value)
        record.errors.add(field, 'is not written in a valid format. Email cannot have capital letters, ' \
                                 'domain must be less than 62 characters and does not allow special characters.')
        next
      end

      next unless check_sendgrid?(record, field, options)

      error_message = RadSendGrid.new.validate_email(email_value)
      record.errors.add(field, error_message) if error_message.present?
    end
  end

  private

    def valid_email?(email)
      email =~ URI::MailTo::EMAIL_REGEXP && email !~ /[A-Z]/
    end

    def check_sendgrid?(record, field, options)
      return false if record.running_global_validity || options[:skip_sendgrid]

      record.send("#{field}_changed?")
    end
end

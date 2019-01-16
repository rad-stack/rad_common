class EmailAddressValidator < ActiveModel::Validator
  def validate(record)
    return if record.blank?

    fields = options[:fields]

    fields.each do |field|
      next if record.send(field).blank?

      check_email(record.send(field), record)
    end
  end

  def check_email(email, record)
    return if email =~ URI::MailTo::EMAIL_REGEXP

    record.errors.add(:email, 'is not written in a valid format')
  end
end

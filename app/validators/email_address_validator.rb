class EmailAddressValidator < ActiveModel::Validator
  def validate(record)
    return if record.blank?

    fields = options[:fields]
    multiples = options[:multiples]

    fields.each do |field|
      next if record.send(field).blank?

      attrs = record.send(field)
      if multiples
        attrs.split(',').each do |attr|
          email = attr.strip
          check_email(email, record)
        end
      else
        check_email(attrs, record)
      end
    end
  end

  def check_email(email, record)
    return if email =~ URI::MailTo::EMAIL_REGEXP

    record.errors.add(:email, 'is not written in a valid format')
  end
end

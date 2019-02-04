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
          attr.class == Array ? attr.each { |email| check_email(email, field, record) } : check_email(attr.strip, field, record)
        end
      else
        check_email(attrs, field, record)
      end
    end
  end

  def check_email(email, field, record)
    return if email =~ URI::MailTo::EMAIL_REGEXP

    record.errors.add(field, 'is not written in a valid format')
  end
end

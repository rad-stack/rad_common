class EmailAddressValidator < ActiveModel::Validator
  def validate(record)
    return if record.blank?

    fields = options[:fields]
    multiples = options[:multiples]

    fields.each do |field|
      next if record.send(field).blank?

      email_value = record.send(field)

      # TODO: downcase emails when in an array as well

      unless email_value.is_a?(Array)
        email_value.downcase!
        record.send("#{field}=", email_value)
      end

      if multiples
        email_value.split(',').each do |attr|
          if attr.instance_of?(Array)
            attr.each { |email| check_email(email, field, record) }
          else
            check_email(attr.strip, field, record)
          end
        end
      else
        check_email(email_value, field, record)
      end
    end
  end

  private

    def check_email(email, field, record)
      return if email =~ URI::MailTo::EMAIL_REGEXP && email !~ /[A-Z]/

      record.errors.add(field, 'is not written in a valid format. Email cannot have capital letters, '\
                                'domain must be less than 62 characters and does not allow special characters.')
    end
end

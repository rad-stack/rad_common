class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    fields = options.has_key?(:fields) ? options[:fields] : [:phone_number]

    fields.each do |field|
      phone_value = fix_phone_number(record, field, record.send(field))
      if phone_value.present? && !valid_phone_number?(phone_value)
        record.errors.add(field, 'invalid, format must be (999) 999-9999')
      end
    end
  end

  def valid_phone_number?(phone_number)
    valid_format(phone_number) && !fake_phone(phone_number)
  end

  def valid_format(phone_number)
    /\A\(\d{3}\) \d{3}-\d{4}( ext \d{1,6}$)?\z/.match(phone_number)
  end

  def fake_phone(phone_number)
    return true if ['(999) 999-9999', '(111) 111-1111', '(904) 123-1234'].include?(phone_number)

    phone_number[1..3] == '000'
  end

  def fix_phone_number(record, field, phone_number)
    if phone_number.present? && phone_number.length == 10 && is_integer?(phone_number)
      record.send("#{field}=", '(' + phone_number[0, 3] + ') ' + phone_number[3, 3] + '-' + phone_number[6, 4])
    end

    record.send(field)
  end

  def is_integer?(string_value)
    /\A[-+]?\d+\z/ === string_value
  end
end

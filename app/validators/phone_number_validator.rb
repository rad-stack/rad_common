class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    fields = options.has_key?(:fields) ? options[:fields] : [{ field: :phone_number }]

    fields.each do |field|
      phone_value = fix_phone_number(record, field[:field], record.send(field[:field]))
      next if phone_value.blank?

      unless valid_phone_number?(phone_value)
        record.errors.add(field[:field], 'invalid, format must be (999) 999-9999')
        next
      end

      next if record.running_global_validity

      mobile = field[:type] && field[:type] == :mobile
      error_message = RadicalTwilio.new.validate_phone_number(phone_value, mobile)
      record.errors.add(field[:field], error_message) if error_message.present?
    end
  end

  private

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
      PhoneNumberFormatter.format(phone_number) do |formatted_number|
        record.send("#{field}=", formatted_number)
      end

      record.send(field)
    end
end

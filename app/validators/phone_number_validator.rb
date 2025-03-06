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

      next unless check_twilio?(record, field)

      mobile = field[:type] && field[:type] == :mobile
      error_message = RadTwilio.new.validate_phone_number(phone_value, mobile)
      record.errors.add(field[:field], error_message) if error_message.present?
    end
  end

  private

    def valid_phone_number?(phone_number)
      valid_format(phone_number)
    end

    def valid_format(phone_number)
      /\A\(\d{3}\) \d{3}-\d{4}( ext \d{1,6}$)?\z/.match(phone_number)
    end

    def fix_phone_number(record, field, phone_number)
      PhoneNumberFormatter.format(phone_number) do |formatted_number|
        record.send("#{field}=", formatted_number)
      end

      record.send(field)
    end

    def check_twilio?(record, field)
      return false if record.running_global_validity
      return true if record.send("#{field[:field]}_changed?")

      # this is a hack to make this work properly for SP, see Task 34650
      return false unless record.respond_to?(:communication_method_id)

      record.communication_method_id_changed?
    end
end

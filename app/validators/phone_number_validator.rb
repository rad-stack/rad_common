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

      next unless RadicalTwilio.twilio_enabled?
      next if record.running_global_validity

      # twilio phone number validations that check whether valid mobile # cost half a penny per request
      next unless record.send("#{field[:field]}_changed?")

      mobile = field[:type] && field[:type] == :mobile

      begin
        response = get_phone_number(phone_value, mobile)

        if mobile && response.carrier['type'] != 'mobile'
          record.errors.add(field[:field], 'does not appear to be a valid mobile phone number')
        end

        response.phone_number
      rescue Twilio::REST::RestError, NoMethodError => e
        Rails.logger.info "twilio lookup error: #{e}"
        record.errors.add(field[:field], 'does not appear to be a valid phone number')
      end
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
      if phone_number.present? && phone_number.length == 10 && integer?(phone_number)
        record.send("#{field}=", "(#{phone_number[0, 3]}) #{phone_number[3, 3]}-#{phone_number[6, 4]}")
      end

      record.send(field)
    end

    def integer?(string_value)
      /\A[-+]?\d+\z/ === string_value
    end

    def get_phone_number(attribute, mobile)
      converted_phone_number = attribute.gsub(/[^0-9a-z\\s]/i, '')
      mobile ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
    end

    def lookup_number(number, type = nil)
      lookup_client = Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))

      RadicalRetry.perform_request(retry_count: 2) do
        if type
          lookup_client.lookups.phone_numbers(number).fetch(type: [type])
        else
          lookup_client.lookups.phone_numbers(number).fetch
        end
      end
    end
end

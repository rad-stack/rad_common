class TwilioPhoneValidator < ActiveModel::Validator
  def validate(record)
    return unless RadicalTwilio.twilio_enabled?
    raise 'please specify options for this validation' unless options && options[:fields]

    fields = options[:fields]
    multiples = options[:multiples]

    # phone number validations that check whether valid mobile # cost half a penny per request
    fields.each do |field|
      next if record.send(field[:field]).blank? || !record.send(field[:field].to_s + '_changed?')

      mobile = field[:type] && field[:type] == :mobile
      attribute = record.send(field[:field])
      if multiples
        numbers = attribute
        message = 'appears to include at least one invalid'
      else
        numbers = [attribute]
        message = 'does not appear to be a valid'
      end

      numbers.each do |number|
        unless PhoneNumberValidator.new.valid_phone_number?(number)
          record.errors.add(field[:field], 'invalid, format must be (999) 999-9999')
          next
        end

        begin
          response = get_phone_number(number, mobile)

          if mobile && response.carrier['type'] != 'mobile'
            record.errors.add(field[:field], "#{message} mobile phone number")
          end

          response.phone_number
        rescue Twilio::REST::RestError, NoMethodError => e
          puts "twilio lookup error: #{e}"
          record.errors.add(field[:field], "#{message} phone number")
        end
      end
    end
  end

  def get_phone_number(attribute, mobile)
    converted_phone_number = attribute.gsub(/[^0-9a-z\\s]/i, '')
    mobile ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
  end

  def lookup_number(number, type = nil)
    lookup_client = Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))

    if type
      lookup_client.lookups.phone_numbers(number).fetch(type: [type])
    else
      lookup_client.lookups.phone_numbers(number).fetch
    end
  end
end

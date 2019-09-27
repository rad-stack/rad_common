class TwilioPhoneValidator < ActiveModel::Validator
  def validate(record)
    return if Company.review_app?
    return unless Rails.env.production? || (defined?(TwilioMockModel) && record.is_a?(TwilioMockModel))
    raise 'please specify options for this validation' unless options && options[:fields]

    fields = options[:fields]

    # phone number validations that check whether valid mobile # cost half a penny per request

    fields.each do |field|
      next unless !record.send(field[:field]).blank? && (record.send(field[:field].to_s + '_changed?') || (use_comm_method(field) && record.communication_method_id_changed?))

      response = get_phone_number(record, field)

      begin
        record.errors.add(field[:field], 'does not appear to be a valid mobile phone number') if is_mobile?(record, field) && response.carrier['type'] != 'mobile'
        response.phone_number
      rescue Twilio::REST::RequestError, NoMethodError => e
        record.errors.add(field[:field], 'does not appear to be a valid phone number')
      end
    end
  end

  def use_comm_method(field)
    field[:type] && field[:type] == :use_communication_method
  end

  def get_phone_number(record, field)
    converted_phone_number = record.send(field[:field]).gsub(/[^0-9a-z\\s]/i, '')
    is_mobile?(record, field) ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
  end

  def lookup_number(number, type = nil)
    lookup_client = Twilio::REST::LookupsClient.new
    type ? lookup_client.phone_numbers.get(number, type: type) : lookup_client.phone_numbers.get(number)
  end

  def is_mobile?(record, field)
    return true if field[:type] && field[:type] == :mobile
    return (record.communication_method == CommunicationMethod.method_sms) if defined?(CommunicationMethod) && use_comm_method(field)

    false
  end
end

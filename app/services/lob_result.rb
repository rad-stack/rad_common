class LobResult
  attr_reader :result

  def initialize(result, zip4_provided)
    @result = result
    @zip4_provided = zip4_provided
  end

  def components
    result['components']
  end

  def address_1
    build_primary_lines(components).select(&:present?).join(' ')
  end

  def address_2
    secondary_line = [components['secondary_designator'], components['secondary_number']]
    secondary_line.select(&:present?).join(' ')
  end

  def city
    components['city']
  end

  def state
    components['state']
  end

  def zipcode
    return components['zip_code'] if components['zip_code_plus_4'].blank? || !zip4_provided?

    "#{components['zip_code']}-#{components['zip_code_plus_4']}"
  end

  def valid_address?
    result['valid_address']
  end

  private

    def build_primary_lines(components)
      if components['street_name'] == 'PO BOX'
        [components['street_name'], components['primary_number']]
      else
        [
          components['primary_number'],
          components['street_predirection'],
          components['street_name'],
          components['street_suffix'],
          components['street_postdirection']
        ]
      end
    end

    def zip4_provided?
      @zip4_provided
    end
end

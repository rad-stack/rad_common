class SmartyResult
  attr_reader :result

  def initialize(result, zip4_provided)
    @result = result
    @zip4_provided = zip4_provided
  end

  def components
    result.first['components']
  end

  def address_1
    build_primary_lines(components).select(&:present?).join(' ')
  end

  def address_2
    secondary_line = [components['secondary_designator'], components['secondary_number']]
    secondary_line.select(&:present?).join(' ')
  end

  def city
    components['city_name']
  end

  def state
    components['state_abbreviation']
  end

  def zipcode
    return components['zipcode'] if components['plus4_code'].blank? || !zip4_provided?

    "#{components['zipcode']}-#{components['plus4_code']}"
  end

  def valid_address?
    result.any? && (postal_match? || non_postal_match?)
  end

  private

    def build_primary_lines(components)
      if components['street_name'] == 'PO Box'
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

    def postal_match?
      analysis['dpv_match_code'] == 'Y'
    end

    def non_postal_match?
      analysis['dpv_match_code'] == 'N' && analysis['enhanced_match'] == 'non-postal-match'
    end

    def analysis
      result.first['analysis']
    end

    def zip4_provided?
      @zip4_provided
    end
end

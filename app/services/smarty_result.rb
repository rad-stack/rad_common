class SmartyResult
  attr_reader :result, :upcase

  def initialize(result, zip4_provided, upcase)
    @result = result
    @zip4_provided = zip4_provided
    @upcase = upcase
  end

  def components
    result.first['components']
  end

  def address_1
    item = build_primary_lines(components).select(&:present?).join(' ').presence
    item = item&.upcase if upcase
    item
  end

  def address_2
    secondary_line = [components['secondary_designator'], components['secondary_number']]
    item = secondary_line.select(&:present?).join(' ').presence
    item = item&.upcase if upcase
    item
  end

  def city
    item = components['city_name'].presence
    item = item&.upcase if upcase
    item
  end

  def state
    item = components['state_abbreviation'].presence
    item = item&.upcase if upcase
    item
  end

  def zipcode
    item = components['zipcode'].presence
    item = item&.upcase if upcase
    return item if components['plus4_code'].blank? || !zip4_provided?

    item = "#{components['zipcode']}-#{components['plus4_code']}".presence
    item = item&.upcase if upcase
    item
  end

  def valid_address?
    result.any? && (postal_match? || non_postal_match? || missing_secondary? || ignoring_secondary?)
  end

  def address_problems
    return if postal_match?
    return 'missing suite or unit #' if missing_secondary?
    return 'verified by ignoring invalid suite or unit #' if ignoring_secondary?
    return 'non-postal match using enhanced address matching' if non_postal_match?

    nil
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

    def ignoring_secondary?
      analysis['dpv_match_code'] == 'S'
    end

    def non_postal_match?
      dpv_match_code = analysis['dpv_match_code']
      (dpv_match_code.nil? || dpv_match_code == 'N') && analysis['enhanced_match'].include?('non-postal-match')
    end

    def missing_secondary?
      analysis['dpv_match_code'] == 'D'
    end

    def analysis
      result.first['analysis']
    end

    def zip4_provided?
      @zip4_provided
    end
end

class SmartyResult
  attr_reader :result

  def initialize(result)
    @result = result
  end

  def components
    result.first['components']
  end

  def address_line_1
    build_primary_lines(components).select(&:present?).join(' ')
  end

  def address_line_2
    secondary_line = [components['secondary_designator'], components['secondary_number']]
    secondary_line.select(&:present?).join(' ')
  end

  def city
    components['city_name']
  end

  def state
    components['state_abbreviation']
  end

  def zip_code
    components['zipcode']
  end

  def deliverable?
    result.any?
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
end

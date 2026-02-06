class StateOptions
  STATE_DATA = [{ code: 'AL', name: 'Alabama', country: 'US' },
                { code: 'AK', name: 'Alaska', country: 'US' },
                { code: 'AZ', name: 'Arizona', country: 'US' },
                { code: 'AR', name: 'Arkansas', country: 'US' },
                { code: 'AS', name: 'American Samoa', country: 'US' },
                { code: 'CA', name: 'California', country: 'US' },
                { code: 'CO', name: 'Colorado', country: 'US' },
                { code: 'CT', name: 'Connecticut', country: 'US' },
                { code: 'DC', name: 'District of Columbia', country: 'US' },
                { code: 'DE', name: 'Delaware', country: 'US' },
                { code: 'FL', name: 'Florida', country: 'US' },
                { code: 'GA', name: 'Georgia', country: 'US' },
                { code: 'GU', name: 'Guam', country: 'US' },
                { code: 'HI', name: 'Hawaii', country: 'US' },
                { code: 'ID', name: 'Idaho', country: 'US' },
                { code: 'IL', name: 'Illinois', country: 'US' },
                { code: 'IN', name: 'Indiana', country: 'US' },
                { code: 'IA', name: 'Iowa', country: 'US' },
                { code: 'KS', name: 'Kansas', country: 'US' },
                { code: 'KY', name: 'Kentucky', country: 'US' },
                { code: 'LA', name: 'Louisiana', country: 'US' },
                { code: 'ME', name: 'Maine', country: 'US' },
                { code: 'MD', name: 'Maryland', country: 'US' },
                { code: 'MA', name: 'Massachusetts', country: 'US' },
                { code: 'MI', name: 'Michigan', country: 'US' },
                { code: 'MN', name: 'Minnesota', country: 'US' },
                { code: 'MS', name: 'Mississippi', country: 'US' },
                { code: 'MO', name: 'Missouri', country: 'US' },
                { code: 'MP', name: 'Northern Mariana Islands', country: 'US' },
                { code: 'MT', name: 'Montana', country: 'US' },
                { code: 'NE', name: 'Nebraska', country: 'US' },
                { code: 'NV', name: 'Nevada', country: 'US' },
                { code: 'NH', name: 'New Hampshire', country: 'US' },
                { code: 'NJ', name: 'New Jersey', country: 'US' },
                { code: 'NM', name: 'New Mexico', country: 'US' },
                { code: 'NY', name: 'New York', country: 'US' },
                { code: 'NC', name: 'North Carolina', country: 'US' },
                { code: 'ND', name: 'North Dakota', country: 'US' },
                { code: 'OH', name: 'Ohio', country: 'US' },
                { code: 'OK', name: 'Oklahoma', country: 'US' },
                { code: 'OR', name: 'Oregon', country: 'US' },
                { code: 'PA', name: 'Pennsylvania', country: 'US' },
                { code: 'PR', name: 'Puerto Rico', country: 'US' },
                { code: 'RI', name: 'Rhode Island', country: 'US' },
                { code: 'SC', name: 'South Carolina', country: 'US' },
                { code: 'SD', name: 'South Dakota', country: 'US' },
                { code: 'TN', name: 'Tennessee', country: 'US' },
                { code: 'TX', name: 'Texas', country: 'US' },
                { code: 'UT', name: 'Utah', country: 'US' },
                { code: 'VT', name: 'Vermont', country: 'US' },
                { code: 'VA', name: 'Virginia', country: 'US' },
                { code: 'VI', name: 'Virgin Islands', country: 'US' },
                { code: 'WA', name: 'Washington', country: 'US' },
                { code: 'WV', name: 'West Virginia', country: 'US' },
                { code: 'WI', name: 'Wisconsin', country: 'US' },
                { code: 'WY', name: 'Wyoming', country: 'US' },
                { code: 'AB', name: 'Alberta', country: 'CA' },
                { code: 'BC', name: 'British Columbia', country: 'CA' },
                { code: 'MB', name: 'Manitoba', country: 'CA' },
                { code: 'NB', name: 'New Brunswick', country: 'CA' },
                { code: 'NL', name: 'Newfoundland and Labrador', country: 'CA' },
                { code: 'NT', name: 'Northwest Territories', country: 'CA' },
                { code: 'NS', name: 'Nova Scotia', country: 'CA' },
                { code: 'NU', name: 'Nunavut', country: 'CA' },
                { code: 'ON', name: 'Ontario', country: 'CA' },
                { code: 'PE', name: 'Prince Edward Island', country: 'CA' },
                { code: 'QC', name: 'Quebec', country: 'CA' },
                { code: 'SK', name: 'Saskatchewan', country: 'CA' },
                { code: 'YT', name: 'Yukon', country: 'CA' }].freeze
  COUNTRIES = { CA: 'Canada', US: 'United States' }.freeze

  class << self
    def options
      active_states.map { |item| map_item_for_select(item) }
    end

    def grouped_options
      @grouped_options ||= active_states.group_by { |item| item[:country] }.map do |country_group|
        [COUNTRIES[country_group.first.to_sym], country_group.last.map { |item| map_item_for_select(item) }]
      end
    end

    def reverse_options
      active_states.map { |item| map_item_for_select(item).reverse }
    end

    def valid?(code)
      active_states.select { |item| item[:code] == code }.present?
    end

    def canadian?(code)
      valid?(code) && active_states.select { |item| item[:code] == code }.first[:country] == 'CA'
    end

    def sample
      active_states.sample[:code]
    end

    def sample_name
      active_states.sample[:name]
    end

    def name_for_code(code)
      results = active_states.select { |item| item[:code] == code }
      return if results.blank?

      results.first[:name]
    end

    def code_for_name(name)
      results = active_states.select { |item| item[:name] == name }
      return if results.blank?

      results.first[:code]
    end

    private

      def active_states
        return STATE_DATA if RadConfig.canadian_addresses?

        STATE_DATA.select { |item| item[:country] == 'US' }
      end

      def map_item_for_select(item)
        [item[:name], item[:code]]
      end
  end
end

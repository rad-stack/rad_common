module Pace
  class Country < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :date_format

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :alt_name

    attr_accessor :allow_vat

    attr_accessor :date_format_pattern

    attr_accessor :numeric_format_pattern

    attr_accessor :vatnumber

    attr_accessor :standard_address_template

    attr_accessor :numeric_format

    attr_accessor :iso_country

    attr_accessor :state_required

    attr_accessor :iso_country_alpha3

    attr_accessor :custom_address_template

    attr_accessor :display_state_code

    attr_accessor :start_of_week

    attr_accessor :time_format_pattern

    attr_accessor :iso_country_number

    attr_accessor :time_format

    attr_accessor :default_iso_country_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'date_format' => :'dateFormat',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'alt_name' => :'altName',
        :'allow_vat' => :'allowVAT',
        :'date_format_pattern' => :'dateFormatPattern',
        :'numeric_format_pattern' => :'numericFormatPattern',
        :'vatnumber' => :'vatnumber',
        :'standard_address_template' => :'standardAddressTemplate',
        :'numeric_format' => :'numericFormat',
        :'iso_country' => :'isoCountry',
        :'state_required' => :'stateRequired',
        :'iso_country_alpha3' => :'isoCountryAlpha3',
        :'custom_address_template' => :'customAddressTemplate',
        :'display_state_code' => :'displayStateCode',
        :'start_of_week' => :'startOfWeek',
        :'time_format_pattern' => :'timeFormatPattern',
        :'iso_country_number' => :'isoCountryNumber',
        :'time_format' => :'timeFormat',
        :'default_iso_country_code' => :'defaultISOCountryCode'
      }
    end
  end
end

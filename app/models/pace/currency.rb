module Pace
  class Currency < Base
    attr_accessor :active

    attr_accessor :zero_digit

    attr_accessor :symbol

    attr_accessor :digit

    attr_accessor :negative_prefix

    attr_accessor :negative_suffix

    attr_accessor :description

    attr_accessor :pattern

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :iso_currency_id

    attr_accessor :display_code

    attr_accessor :pattern_seperator

    attr_accessor :sample

    attr_accessor :symbol_location

    attr_accessor :decimal_seperator

    attr_accessor :group_seperator

    attr_accessor :current_exchange_rate

    attr_accessor :display_currency_code

    attr_accessor :group_size

    attr_accessor :conversion


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'zero_digit' => :'zeroDigit',
        :'symbol' => :'symbol',
        :'digit' => :'digit',
        :'negative_prefix' => :'negativePrefix',
        :'negative_suffix' => :'negativeSuffix',
        :'description' => :'description',
        :'pattern' => :'pattern',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'iso_currency_id' => :'isoCurrencyId',
        :'display_code' => :'displayCode',
        :'pattern_seperator' => :'patternSeperator',
        :'sample' => :'sample',
        :'symbol_location' => :'symbolLocation',
        :'decimal_seperator' => :'decimalSeperator',
        :'group_seperator' => :'groupSeperator',
        :'current_exchange_rate' => :'currentExchangeRate',
        :'display_currency_code' => :'displayCurrencyCode',
        :'group_size' => :'groupSize',
        :'conversion' => :'conversion'
      }
    end
  end
end

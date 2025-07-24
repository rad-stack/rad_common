module Pace
  class CurrencyExchangeRate < Base
    attr_accessor :id

    attr_accessor :currency

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :inverse

    attr_accessor :exchange_rate

    attr_accessor :effective_time

    attr_accessor :effective_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'currency' => :'currency',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'inverse' => :'inverse',
        :'exchange_rate' => :'exchangeRate',
        :'effective_time' => :'effectiveTime',
        :'effective_date' => :'effectiveDate'
      }
    end
  end
end

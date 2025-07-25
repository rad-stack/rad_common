module Pace
  class ReceivablePaymentGroupLine < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :receivable

    attr_accessor :payment_amount

    attr_accessor :receivable_payment_group


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'receivable' => :'receivable',
        :'payment_amount' => :'paymentAmount',
        :'receivable_payment_group' => :'receivablePaymentGroup'
      }
    end
  end
end

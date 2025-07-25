module Pace
  class ReceivablePaymentGroup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :capture_time

    attr_accessor :capture_token

    attr_accessor :capture_full_amount

    attr_accessor :pnref

    attr_accessor :payment_amount

    attr_accessor :capture_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'capture_time' => :'captureTime',
        :'capture_token' => :'captureToken',
        :'capture_full_amount' => :'captureFullAmount',
        :'pnref' => :'pnref',
        :'payment_amount' => :'paymentAmount',
        :'capture_date' => :'captureDate'
      }
    end
  end
end

module Pace
  class BillCheck < Base
    attr_accessor :id

    attr_accessor :void

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :manual

    attr_accessor :amount

    attr_accessor :original_id

    attr_accessor :discount_amount

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :gl_account

    attr_accessor :check_number

    attr_accessor :adjustment_amount

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :check_date

    attr_accessor :bank_account

    attr_accessor :bill

    attr_accessor :print_check

    attr_accessor :accounting_period

    attr_accessor :bill_payment_batch


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'void' => :'void',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'manual' => :'manual',
        :'amount' => :'amount',
        :'original_id' => :'originalId',
        :'discount_amount' => :'discountAmount',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'gl_account' => :'glAccount',
        :'check_number' => :'checkNumber',
        :'adjustment_amount' => :'adjustmentAmount',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'check_date' => :'checkDate',
        :'bank_account' => :'bankAccount',
        :'bill' => :'bill',
        :'print_check' => :'printCheck',
        :'accounting_period' => :'accountingPeriod',
        :'bill_payment_batch' => :'billPaymentBatch'
      }
    end
  end
end

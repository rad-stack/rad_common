module Pace
  class BillPayment < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :original_id

    attr_accessor :discount_amount

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :gl_account

    attr_accessor :check_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :vendor

    attr_accessor :alt_currency_rate_source

    attr_accessor :bank_account

    attr_accessor :bill

    attr_accessor :bank_account_line

    attr_accessor :accounting_period

    attr_accessor :payment_date

    attr_accessor :bill_payment_batch

    attr_accessor :voided

    attr_accessor :original_transaction


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'original_id' => :'originalId',
        :'discount_amount' => :'discountAmount',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'gl_account' => :'glAccount',
        :'check_number' => :'checkNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'vendor' => :'vendor',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'bank_account' => :'bankAccount',
        :'bill' => :'bill',
        :'bank_account_line' => :'bankAccountLine',
        :'accounting_period' => :'accountingPeriod',
        :'payment_date' => :'paymentDate',
        :'bill_payment_batch' => :'billPaymentBatch',
        :'voided' => :'voided',
        :'original_transaction' => :'originalTransaction'
      }
    end
  end
end

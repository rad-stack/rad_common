module Pace
  class Payment < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :balanced

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :customer

    attr_accessor :balance

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :gl_account

    attr_accessor :check_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :invoice_number

    attr_accessor :alt_currency_rate_source

    attr_accessor :tax_code

    attr_accessor :capture_time

    attr_accessor :capture_token

    attr_accessor :capture_full_amount

    attr_accessor :pnref

    attr_accessor :capture_date

    attr_accessor :entry_type

    attr_accessor :deposit_type

    attr_accessor :balance_remaining

    attr_accessor :payment_batch

    attr_accessor :receivable_selection_method

    attr_accessor :quick_payment

    attr_accessor :auto_apply

    attr_accessor :receivable_payment_group

    attr_accessor :payment_note

    attr_accessor :payment_reversal_note

    attr_accessor :payment_line_note

    attr_accessor :payment_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'balanced' => :'balanced',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'customer' => :'customer',
        :'balance' => :'balance',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'gl_account' => :'glAccount',
        :'check_number' => :'checkNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'invoice_number' => :'invoiceNumber',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'tax_code' => :'taxCode',
        :'capture_time' => :'captureTime',
        :'capture_token' => :'captureToken',
        :'capture_full_amount' => :'captureFullAmount',
        :'pnref' => :'pnref',
        :'capture_date' => :'captureDate',
        :'entry_type' => :'entryType',
        :'deposit_type' => :'depositType',
        :'balance_remaining' => :'balanceRemaining',
        :'payment_batch' => :'paymentBatch',
        :'receivable_selection_method' => :'receivableSelectionMethod',
        :'quick_payment' => :'quickPayment',
        :'auto_apply' => :'autoApply',
        :'receivable_payment_group' => :'receivablePaymentGroup',
        :'payment_note' => :'paymentNote',
        :'payment_reversal_note' => :'paymentReversalNote',
        :'payment_line_note' => :'paymentLineNote',
        :'payment_date' => :'paymentDate'
      }
    end
  end
end

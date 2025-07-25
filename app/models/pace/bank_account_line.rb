module Pace
  class BankAccountLine < Base
    attr_accessor :id

    attr_accessor :cleared

    attr_accessor :date

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :bank_account_id

    attr_accessor :gl_register_number

    attr_accessor :amount

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :check_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :payment_batch

    attr_accessor :statement_id

    attr_accessor :check_type

    attr_accessor :clear_date

    attr_accessor :debit_amount

    attr_accessor :bank_statement_id

    attr_accessor :credit_amount

    attr_accessor :clear_alt_currency_rate


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'cleared' => :'cleared',
        :'date' => :'date',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'bank_account_id' => :'bankAccountID',
        :'gl_register_number' => :'glRegisterNumber',
        :'amount' => :'amount',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'check_number' => :'checkNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'payment_batch' => :'paymentBatch',
        :'statement_id' => :'statementID',
        :'check_type' => :'checkType',
        :'clear_date' => :'clearDate',
        :'debit_amount' => :'debitAmount',
        :'bank_statement_id' => :'bankStatementID',
        :'credit_amount' => :'creditAmount',
        :'clear_alt_currency_rate' => :'clearAltCurrencyRate'
      }
    end
  end
end

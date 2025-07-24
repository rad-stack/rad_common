module Pace
  class BankAccount < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :account_title

    attr_accessor :bsb_id

    attr_accessor :iban_account_id

    attr_accessor :swift_number

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :gl_account

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :last_check_number

    attr_accessor :statement_date

    attr_accessor :statement_balance

    attr_accessor :bank_id

    attr_accessor :last_statement_date

    attr_accessor :last_reconcile_date

    attr_accessor :opening_balance

    attr_accessor :outstanding_balance

    attr_accessor :cleared_balance

    attr_accessor :total_balance

    attr_accessor :account_number

    attr_accessor :eft_id

    attr_accessor :routing_number

    attr_accessor :credit_card

    attr_accessor :beginning_gl_amount


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'account_title' => :'accountTitle',
        :'bsb_id' => :'bsbID',
        :'iban_account_id' => :'ibanAccountID',
        :'swift_number' => :'swiftNumber',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'gl_account' => :'glAccount',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'last_check_number' => :'lastCheckNumber',
        :'statement_date' => :'statementDate',
        :'statement_balance' => :'statementBalance',
        :'bank_id' => :'bankID',
        :'last_statement_date' => :'lastStatementDate',
        :'last_reconcile_date' => :'lastReconcileDate',
        :'opening_balance' => :'openingBalance',
        :'outstanding_balance' => :'outstandingBalance',
        :'cleared_balance' => :'clearedBalance',
        :'total_balance' => :'totalBalance',
        :'account_number' => :'accountNumber',
        :'eft_id' => :'eftID',
        :'routing_number' => :'routingNumber',
        :'credit_card' => :'creditCard',
        :'beginning_gl_amount' => :'beginningGLAmount'
      }
    end
  end
end

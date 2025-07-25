module Pace
  class BankStatement < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :bank_account_id

    attr_accessor :balanced

    attr_accessor :date_time_setup

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :opening_balance

    attr_accessor :statement_id

    attr_accessor :ending_balance

    attr_accessor :ending_date

    attr_accessor :opening_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'bank_account_id' => :'bankAccountID',
        :'balanced' => :'balanced',
        :'date_time_setup' => :'dateTimeSetup',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'opening_balance' => :'openingBalance',
        :'statement_id' => :'statementID',
        :'ending_balance' => :'endingBalance',
        :'ending_date' => :'endingDate',
        :'opening_date' => :'openingDate'
      }
    end
  end
end

module Pace
  class Receivable < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :avail_remaining_deposit

    attr_accessor :reversal_of

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :invoice_date

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sales_category

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :salutation

    attr_accessor :taxable_code

    attr_accessor :legal_entity

    attr_accessor :customer_type

    attr_accessor :gl_register_number

    attr_accessor :customer

    attr_accessor :orginal_batch_id

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :gl_accounting_period

    attr_accessor :original_id

    attr_accessor :expected_payment_date

    attr_accessor :invoice_amount

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :pay

    attr_accessor :po_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :invoice_number

    attr_accessor :alt_currency_rate_source

    attr_accessor :amount_due

    attr_accessor :tax_base

    attr_accessor :tax_amount

    attr_accessor :charge_back_account

    attr_accessor :due_date

    attr_accessor :commission_rate

    attr_accessor :target_sell

    attr_accessor :commission_base

    attr_accessor :pnref

    attr_accessor :deposit_type

    attr_accessor :date_paid_off

    attr_accessor :debit_credit_reason

    attr_accessor :tax_rate7_amount

    attr_accessor :discount_base

    attr_accessor :date_commission_lost

    attr_accessor :tax_rate4_amount

    attr_accessor :tax_rate22_amount

    attr_accessor :deposit_payment

    attr_accessor :last_dunning_aging_category

    attr_accessor :tax_rate17_amount

    attr_accessor :discount_date

    attr_accessor :tax_rate14_amount

    attr_accessor :commission_amount

    attr_accessor :appliance_id

    attr_accessor :tax_rate21_amount

    attr_accessor :tax_rate5_amount

    attr_accessor :discount_available

    attr_accessor :last_dunning_date

    attr_accessor :date_commission_paid

    attr_accessor :tax_rate15_amount

    attr_accessor :deposit_check_number

    attr_accessor :freight_amount

    attr_accessor :next_dunning_aging_category

    attr_accessor :overall_billing_journal_entry

    attr_accessor :unpaid_amount

    attr_accessor :tax_rate16_amount

    attr_accessor :discount_base_forced

    attr_accessor :business_unit

    attr_accessor :collection_notes

    attr_accessor :tax_rate13_amount

    attr_accessor :tax_rate23_amount

    attr_accessor :send_dunning_letter

    attr_accessor :tax_rate10_amount

    attr_accessor :tax_rate20_amount

    attr_accessor :discount_applied

    attr_accessor :tax_rate6_amount

    attr_accessor :tax_rate3_amount

    attr_accessor :tax_rate11_amount

    attr_accessor :tax_rate18_amount

    attr_accessor :apply_amount

    attr_accessor :form_number

    attr_accessor :tax_rate1_amount

    attr_accessor :tax_rate25_amount

    attr_accessor :tax_rate9_amount

    attr_accessor :tax_rate12_amount

    attr_accessor :tax_rate2_amount

    attr_accessor :tax_rate24_amount

    attr_accessor :tax_rate8_amount

    attr_accessor :overall_currency_exchange_journal_entry

    attr_accessor :original_amount

    attr_accessor :tax_rate19_amount

    attr_accessor :aging_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'avail_remaining_deposit' => :'availRemainingDeposit',
        :'reversal_of' => :'reversalOf',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'invoice_date' => :'invoiceDate',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sales_category' => :'salesCategory',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'salutation' => :'salutation',
        :'taxable_code' => :'taxableCode',
        :'legal_entity' => :'legalEntity',
        :'customer_type' => :'customerType',
        :'gl_register_number' => :'glRegisterNumber',
        :'customer' => :'customer',
        :'orginal_batch_id' => :'orginalBatchId',
        # :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'original_id' => :'originalId',
        :'expected_payment_date' => :'expectedPaymentDate',
        :'invoice_amount' => :'invoiceAmount',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'pay' => :'pay',
        :'po_number' => :'poNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'invoice_number' => :'invoiceNumber',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'amount_due' => :'amountDue',
        :'tax_base' => :'taxBase',
        :'tax_amount' => :'taxAmount',
        :'charge_back_account' => :'chargeBackAccount',
        :'due_date' => :'dueDate',
        :'commission_rate' => :'commissionRate',
        :'target_sell' => :'targetSell',
        :'commission_base' => :'commissionBase',
        :'pnref' => :'pnref',
        :'deposit_type' => :'depositType',
        :'date_paid_off' => :'datePaidOff',
        :'debit_credit_reason' => :'debitCreditReason',
        :'tax_rate7_amount' => :'taxRate7Amount',
        :'discount_base' => :'discountBase',
        :'date_commission_lost' => :'dateCommissionLost',
        :'tax_rate4_amount' => :'taxRate4Amount',
        :'tax_rate22_amount' => :'taxRate22Amount',
        :'deposit_payment' => :'depositPayment',
        :'last_dunning_aging_category' => :'lastDunningAgingCategory',
        :'tax_rate17_amount' => :'taxRate17Amount',
        :'discount_date' => :'discountDate',
        :'tax_rate14_amount' => :'taxRate14Amount',
        :'commission_amount' => :'commissionAmount',
        :'appliance_id' => :'applianceId',
        :'tax_rate21_amount' => :'taxRate21Amount',
        :'tax_rate5_amount' => :'taxRate5Amount',
        :'discount_available' => :'discountAvailable',
        :'last_dunning_date' => :'lastDunningDate',
        :'date_commission_paid' => :'dateCommissionPaid',
        :'tax_rate15_amount' => :'taxRate15Amount',
        :'deposit_check_number' => :'depositCheckNumber',
        :'freight_amount' => :'freightAmount',
        :'next_dunning_aging_category' => :'nextDunningAgingCategory',
        :'overall_billing_journal_entry' => :'overallBillingJournalEntry',
        :'unpaid_amount' => :'unpaidAmount',
        :'tax_rate16_amount' => :'taxRate16Amount',
        :'discount_base_forced' => :'discountBaseForced',
        :'business_unit' => :'businessUnit',
        :'collection_notes' => :'collectionNotes',
        :'tax_rate13_amount' => :'taxRate13Amount',
        :'tax_rate23_amount' => :'taxRate23Amount',
        :'send_dunning_letter' => :'sendDunningLetter',
        :'tax_rate10_amount' => :'taxRate10Amount',
        :'tax_rate20_amount' => :'taxRate20Amount',
        :'discount_applied' => :'discountApplied',
        :'tax_rate6_amount' => :'taxRate6Amount',
        :'tax_rate3_amount' => :'taxRate3Amount',
        :'tax_rate11_amount' => :'taxRate11Amount',
        :'tax_rate18_amount' => :'taxRate18Amount',
        :'apply_amount' => :'applyAmount',
        :'form_number' => :'formNumber',
        :'tax_rate1_amount' => :'taxRate1Amount',
        :'tax_rate25_amount' => :'taxRate25Amount',
        :'tax_rate9_amount' => :'taxRate9Amount',
        :'tax_rate12_amount' => :'taxRate12Amount',
        :'tax_rate2_amount' => :'taxRate2Amount',
        :'tax_rate24_amount' => :'taxRate24Amount',
        :'tax_rate8_amount' => :'taxRate8Amount',
        :'overall_currency_exchange_journal_entry' => :'overallCurrencyExchangeJournalEntry',
        :'original_amount' => :'originalAmount',
        :'tax_rate19_amount' => :'taxRate19Amount',
        :'aging_category' => :'agingCategory'
      }
    end
  end
end

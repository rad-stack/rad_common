module Pace
  class ARSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_days_until_job_due

    attr_accessor :gl_register_number_sequence

    attr_accessor :aging4_days

    attr_accessor :aging1_days

    attr_accessor :allow_process_all

    attr_accessor :default_terms

    attr_accessor :discounts_gl_account

    attr_accessor :aging2_days

    attr_accessor :apply_credits_to_last_aging

    attr_accessor :aging3_days

    attr_accessor :aging_date

    attr_accessor :last_dunning_date

    attr_accessor :default_ship_via

    attr_accessor :receivable_selection_method

    attr_accessor :customer_number

    attr_accessor :email_results

    attr_accessor :default_sales_category

    attr_accessor :default_sales_person

    attr_accessor :advanced_dunning

    attr_accessor :business_day_start

    attr_accessor :default_auto_add_contact

    attr_accessor :default_statement_cycle

    attr_accessor :interface_with_general_ledger

    attr_accessor :validate_chargeback_by_job

    attr_accessor :validate_chargeback_by_shipment

    attr_accessor :commission_gl_department

    attr_accessor :commission_never_lost

    attr_accessor :default_deposit_type

    attr_accessor :discounts_gl_department

    attr_accessor :aging_category_for_credit_hold

    attr_accessor :default_customer_type

    attr_accessor :minimum_balance_for_results_email

    attr_accessor :discounts_gl_location

    attr_accessor :auto_apply_invoice_selection

    attr_accessor :require_external_accounting_id

    attr_accessor :minimum_service_charge

    attr_accessor :percent_paid_for_commission

    attr_accessor :allow_overpayment

    attr_accessor :days_till_commission_lost

    attr_accessor :misc_receipt_tax

    attr_accessor :search_by_customer_name

    attr_accessor :default_commission_sales_category

    attr_accessor :do_not_calculate_work_in_progress

    attr_accessor :interface_with_bank_rec

    attr_accessor :calculate_aging_totals

    attr_accessor :allow_charge_back_sales_dist

    attr_accessor :payment_weight

    attr_accessor :credit_hold_status

    attr_accessor :credit_hold_minimum

    attr_accessor :commission_gl_location

    attr_accessor :start_computing_service_charges_at

    attr_accessor :sum_ytd_sales_for_sales_only

    attr_accessor :background_calculate_work_in_progress

    attr_accessor :credit_card_posting_method

    attr_accessor :default_sales_tax

    attr_accessor :use_unposted_payments

    attr_accessor :auto_apply_reverse_invoice

    attr_accessor :commission_liability_account

    attr_accessor :default_bank

    attr_accessor :email_aging_results

    attr_accessor :default_csr

    attr_accessor :ask_bank_on_payment_entry

    attr_accessor :use_last_payment_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_days_until_job_due' => :'defaultDaysUntilJobDue',
        :'gl_register_number_sequence' => :'glRegisterNumberSequence',
        :'aging4_days' => :'aging4Days',
        :'aging1_days' => :'aging1Days',
        :'allow_process_all' => :'allowProcessAll',
        :'default_terms' => :'defaultTerms',
        :'discounts_gl_account' => :'discountsGLAccount',
        :'aging2_days' => :'aging2Days',
        :'apply_credits_to_last_aging' => :'applyCreditsToLastAging',
        :'aging3_days' => :'aging3Days',
        :'aging_date' => :'agingDate',
        :'last_dunning_date' => :'lastDunningDate',
        :'default_ship_via' => :'defaultShipVia',
        :'receivable_selection_method' => :'receivableSelectionMethod',
        :'customer_number' => :'customerNumber',
        :'email_results' => :'emailResults',
        :'default_sales_category' => :'defaultSalesCategory',
        :'default_sales_person' => :'defaultSalesPerson',
        :'advanced_dunning' => :'advancedDunning',
        :'business_day_start' => :'businessDayStart',
        :'default_auto_add_contact' => :'defaultAutoAddContact',
        :'default_statement_cycle' => :'defaultStatementCycle',
        :'interface_with_general_ledger' => :'interfaceWithGeneralLedger',
        :'validate_chargeback_by_job' => :'validateChargebackByJob',
        :'validate_chargeback_by_shipment' => :'validateChargebackByShipment',
        :'commission_gl_department' => :'commissionGlDepartment',
        :'commission_never_lost' => :'commissionNeverLost',
        :'default_deposit_type' => :'defaultDepositType',
        :'discounts_gl_department' => :'discountsGlDepartment',
        :'aging_category_for_credit_hold' => :'agingCategoryForCreditHold',
        :'default_customer_type' => :'defaultCustomerType',
        :'minimum_balance_for_results_email' => :'minimumBalanceForResultsEmail',
        :'discounts_gl_location' => :'discountsGlLocation',
        :'auto_apply_invoice_selection' => :'autoApplyInvoiceSelection',
        :'require_external_accounting_id' => :'requireExternalAccountingId',
        :'minimum_service_charge' => :'minimumServiceCharge',
        :'percent_paid_for_commission' => :'percentPaidForCommission',
        :'allow_overpayment' => :'allowOverpayment',
        :'days_till_commission_lost' => :'daysTillCommissionLost',
        :'misc_receipt_tax' => :'miscReceiptTax',
        :'search_by_customer_name' => :'searchByCustomerName',
        :'default_commission_sales_category' => :'defaultCommissionSalesCategory',
        :'do_not_calculate_work_in_progress' => :'doNotCalculateWorkInProgress',
        :'interface_with_bank_rec' => :'interfaceWithBankRec',
        :'calculate_aging_totals' => :'calculateAgingTotals',
        :'allow_charge_back_sales_dist' => :'allowChargeBackSalesDist',
        :'payment_weight' => :'paymentWeight',
        :'credit_hold_status' => :'creditHoldStatus',
        :'credit_hold_minimum' => :'creditHoldMinimum',
        :'commission_gl_location' => :'commissionGlLocation',
        :'start_computing_service_charges_at' => :'startComputingServiceChargesAt',
        :'sum_ytd_sales_for_sales_only' => :'sumYTDSalesForSalesOnly',
        :'background_calculate_work_in_progress' => :'backgroundCalculateWorkInProgress',
        :'credit_card_posting_method' => :'creditCardPostingMethod',
        :'default_sales_tax' => :'defaultSalesTax',
        :'use_unposted_payments' => :'useUnpostedPayments',
        :'auto_apply_reverse_invoice' => :'autoApplyReverseInvoice',
        :'commission_liability_account' => :'commissionLiabilityAccount',
        :'default_bank' => :'defaultBank',
        :'email_aging_results' => :'emailAgingResults',
        :'default_csr' => :'defaultCSR',
        :'ask_bank_on_payment_entry' => :'askBankOnPaymentEntry',
        :'use_last_payment_date' => :'useLastPaymentDate'
      }
    end
  end
end

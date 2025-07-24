module Pace
  class GLSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_register_number_sequence

    attr_accessor :allow_process_all

    attr_accessor :interface_jc

    attr_accessor :default_location

    attr_accessor :auto_post_ap_bills

    attr_accessor :default_balance_sheet_department

    attr_accessor :base_percent_account

    attr_accessor :earn_before_tax

    attr_accessor :gl_location_from

    attr_accessor :auto_post_job_costs

    attr_accessor :fiscal_year_begins

    attr_accessor :ask_activity_code

    attr_accessor :auto_post_ap_payments

    attr_accessor :reconcile_locations

    attr_accessor :post_summary_entries

    attr_accessor :default_calculate_balance_range

    attr_accessor :current_period

    attr_accessor :use_gl_department_location_associations

    attr_accessor :earnings_account

    attr_accessor :duplicate_last_journal_entry

    attr_accessor :use_legacy_calculate_balances_algorithm

    attr_accessor :period_today

    attr_accessor :auto_post_fixed_assets

    attr_accessor :bank_account_realized_gain_loss_expense

    attr_accessor :use_departments

    attr_accessor :auto_post_jb

    attr_accessor :auto_post_ar

    attr_accessor :auto_post_inventory

    attr_accessor :net_account

    attr_accessor :default_department

    attr_accessor :receivables_realized_gain_loss_expense

    attr_accessor :payables_realized_gain_loss_expense

    attr_accessor :prior_year_earnings

    attr_accessor :entry_date_option

    attr_accessor :last_bal_sheet_account

    attr_accessor :must_close_year

    attr_accessor :auto_calculate_balances


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_register_number_sequence' => :'glRegisterNumberSequence',
        :'allow_process_all' => :'allowProcessAll',
        :'interface_jc' => :'interfaceJC',
        :'default_location' => :'defaultLocation',
        :'auto_post_ap_bills' => :'autoPostAPBills',
        :'default_balance_sheet_department' => :'defaultBalanceSheetDepartment',
        :'base_percent_account' => :'basePercentAccount',
        :'earn_before_tax' => :'earnBeforeTax',
        :'gl_location_from' => :'glLocationFrom',
        :'auto_post_job_costs' => :'autoPostJobCosts',
        :'fiscal_year_begins' => :'fiscalYearBegins',
        :'ask_activity_code' => :'askActivityCode',
        :'auto_post_ap_payments' => :'autoPostAPPayments',
        :'reconcile_locations' => :'reconcileLocations',
        :'post_summary_entries' => :'postSummaryEntries',
        :'default_calculate_balance_range' => :'defaultCalculateBalanceRange',
        :'current_period' => :'currentPeriod',
        :'use_gl_department_location_associations' => :'useGLDepartmentLocationAssociations',
        :'earnings_account' => :'earningsAccount',
        :'duplicate_last_journal_entry' => :'duplicateLastJournalEntry',
        :'use_legacy_calculate_balances_algorithm' => :'useLegacyCalculateBalancesAlgorithm',
        :'period_today' => :'periodToday',
        :'auto_post_fixed_assets' => :'autoPostFixedAssets',
        :'bank_account_realized_gain_loss_expense' => :'bankAccountRealizedGainLossExpense',
        :'use_departments' => :'useDepartments',
        :'auto_post_jb' => :'autoPostJB',
        :'auto_post_ar' => :'autoPostAR',
        :'auto_post_inventory' => :'autoPostInventory',
        :'net_account' => :'netAccount',
        :'default_department' => :'defaultDepartment',
        :'receivables_realized_gain_loss_expense' => :'receivablesRealizedGainLossExpense',
        :'payables_realized_gain_loss_expense' => :'payablesRealizedGainLossExpense',
        :'prior_year_earnings' => :'priorYearEarnings',
        :'entry_date_option' => :'entryDateOption',
        :'last_bal_sheet_account' => :'lastBalSheetAccount',
        :'must_close_year' => :'mustCloseYear',
        :'auto_calculate_balances' => :'autoCalculateBalances'
      }
    end
  end
end

module Pace
  class PayrollSetup < Base
    attr_accessor :use_bank_rec

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :overtime_pay_type

    attr_accessor :default_bank_account

    attr_accessor :days_in_period

    attr_accessor :period_begin_time

    attr_accessor :print_zero_checks

    attr_accessor :sick_pay_type

    attr_accessor :begin_department

    attr_accessor :regular_pay_type

    attr_accessor :use_general_ledger

    attr_accessor :period_end_time

    attr_accessor :doubletime_pay_type

    attr_accessor :period_begin_date

    attr_accessor :end_department

    attr_accessor :salary_pay_type

    attr_accessor :use_accounts_payable

    attr_accessor :use_data_collection

    attr_accessor :payroll_setup_id

    attr_accessor :vacation_pay_type

    attr_accessor :pay_basis

    attr_accessor :commission_pay_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'use_bank_rec' => :'useBankRec',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'overtime_pay_type' => :'overtimePayType',
        :'default_bank_account' => :'defaultBankAccount',
        :'days_in_period' => :'daysInPeriod',
        :'period_begin_time' => :'periodBeginTime',
        :'print_zero_checks' => :'printZeroChecks',
        :'sick_pay_type' => :'sickPayType',
        :'begin_department' => :'beginDepartment',
        :'regular_pay_type' => :'regularPayType',
        :'use_general_ledger' => :'useGeneralLedger',
        :'period_end_time' => :'periodEndTime',
        :'doubletime_pay_type' => :'doubletimePayType',
        :'period_begin_date' => :'periodBeginDate',
        :'end_department' => :'endDepartment',
        :'salary_pay_type' => :'salaryPayType',
        :'use_accounts_payable' => :'useAccountsPayable',
        :'use_data_collection' => :'useDataCollection',
        :'payroll_setup_id' => :'payrollSetupID',
        :'vacation_pay_type' => :'vacationPayType',
        :'pay_basis' => :'payBasis',
        :'commission_pay_type' => :'commissionPayType'
      }
    end
  end
end

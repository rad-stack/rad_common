module Pace
  class EmployeePayrollDeduction < Base
    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :account_title

    attr_accessor :payroll_tax_table_id

    attr_accessor :amount

    attr_accessor :employee_id

    attr_accessor :payroll_deduction_type_id

    attr_accessor :account_number

    attr_accessor :routing_number

    attr_accessor :period

    attr_accessor :annual_limit

    attr_accessor :employee_bank_account_id

    attr_accessor :total_amount_this_year

    attr_accessor :account_type

    attr_accessor :filing_status

    attr_accessor :exemptions

    attr_accessor :total_amount_last_year

    attr_accessor :employee_payroll_deduction_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'account_title' => :'accountTitle',
        :'payroll_tax_table_id' => :'payrollTaxTableID',
        :'amount' => :'amount',
        :'employee_id' => :'employeeID',
        :'payroll_deduction_type_id' => :'payrollDeductionTypeID',
        :'account_number' => :'accountNumber',
        :'routing_number' => :'routingNumber',
        :'period' => :'period',
        :'annual_limit' => :'annualLimit',
        :'employee_bank_account_id' => :'employeeBankAccountID',
        :'total_amount_this_year' => :'totalAmountThisYear',
        :'account_type' => :'accountType',
        :'filing_status' => :'filingStatus',
        :'exemptions' => :'exemptions',
        :'total_amount_last_year' => :'totalAmountLastYear',
        :'employee_payroll_deduction_id' => :'employeePayrollDeductionID'
      }
    end
  end
end

module Pace
  class PayrollCheck < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :bank_account_id

    attr_accessor :posted

    attr_accessor :approved

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :check_number

    attr_accessor :employee_id

    attr_accessor :payroll_batch_id

    attr_accessor :check_amount

    attr_accessor :payroll_check_type_id

    attr_accessor :gross_pay

    attr_accessor :payroll_check_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'bank_account_id' => :'bankAccountID',
        :'posted' => :'posted',
        :'approved' => :'approved',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'check_number' => :'checkNumber',
        :'employee_id' => :'employeeID',
        :'payroll_batch_id' => :'payrollBatchID',
        :'check_amount' => :'checkAmount',
        :'payroll_check_type_id' => :'payrollCheckTypeID',
        :'gross_pay' => :'grossPay',
        :'payroll_check_id' => :'payrollCheckID'
      }
    end
  end
end

module Pace
  class PayrollCheckLine < Base
    attr_accessor :hours

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :amount

    attr_accessor :hours_forced

    attr_accessor :payroll_check_id

    attr_accessor :payroll_pay_type_id

    attr_accessor :payroll_deduction_type_id

    attr_accessor :account_number

    attr_accessor :rate

    attr_accessor :deduction_base

    attr_accessor :amount_forced

    attr_accessor :hourly_rate_forced

    attr_accessor :payroll_check_line_id

    attr_accessor :hourly_rate

    attr_accessor :pay_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'hours' => :'hours',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'amount' => :'amount',
        :'hours_forced' => :'hoursForced',
        :'payroll_check_id' => :'payrollCheckID',
        :'payroll_pay_type_id' => :'payrollPayTypeID',
        :'payroll_deduction_type_id' => :'payrollDeductionTypeID',
        :'account_number' => :'accountNumber',
        :'rate' => :'rate',
        :'deduction_base' => :'deductionBase',
        :'amount_forced' => :'amountForced',
        :'hourly_rate_forced' => :'hourlyRateForced',
        :'payroll_check_line_id' => :'payrollCheckLineID',
        :'hourly_rate' => :'hourlyRate',
        :'pay_date' => :'payDate'
      }
    end
  end
end

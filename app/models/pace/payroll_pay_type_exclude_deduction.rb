module Pace
  class PayrollPayTypeExcludeDeduction < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :payroll_pay_type_id

    attr_accessor :exclude_deduction_id

    attr_accessor :payroll_deduction_type_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'payroll_pay_type_id' => :'payrollPayTypeID',
        :'exclude_deduction_id' => :'excludeDeductionID',
        :'payroll_deduction_type_id' => :'payrollDeductionTypeID'
      }
    end
  end
end

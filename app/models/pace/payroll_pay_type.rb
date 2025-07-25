module Pace
  class PayrollPayType < Base
    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :xpath_expression

    attr_accessor :payroll_pay_type_id

    attr_accessor :print_sequence

    attr_accessor :gl_account_id

    attr_accessor :standard_pay_type

    attr_accessor :calc_method

    attr_accessor :rate_factor

    attr_accessor :hours_worked


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'xpath_expression' => :'xpathExpression',
        :'payroll_pay_type_id' => :'payrollPayTypeID',
        :'print_sequence' => :'printSequence',
        :'gl_account_id' => :'glAccountID',
        :'standard_pay_type' => :'standardPayType',
        :'calc_method' => :'calcMethod',
        :'rate_factor' => :'rateFactor',
        :'hours_worked' => :'hoursWorked'
      }
    end
  end
end

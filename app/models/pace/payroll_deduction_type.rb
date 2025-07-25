module Pace
  class PayrollDeductionType < Base
    attr_accessor :active

    attr_accessor :country

    attr_accessor :locale

    attr_accessor :percent

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :xpath_expression

    attr_accessor :sequence

    attr_accessor :state_key

    attr_accessor :payroll_tax_table_id

    attr_accessor :amount

    attr_accessor :payroll_deduction_type_id

    attr_accessor :vendor_id

    attr_accessor :deduction_base_type

    attr_accessor :deduction_type

    attr_accessor :state_id

    attr_accessor :separate_check

    attr_accessor :max_per_pay_period

    attr_accessor :company_paid

    attr_accessor :w2_code

    attr_accessor :show_on_check

    attr_accessor :gl_account_id

    attr_accessor :min_per_pay_period

    attr_accessor :annual_limit

    attr_accessor :default_employee

    attr_accessor :sec125_exempt


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'country' => :'country',
        :'locale' => :'locale',
        :'percent' => :'percent',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'xpath_expression' => :'xpathExpression',
        :'sequence' => :'sequence',
        :'state_key' => :'stateKey',
        :'payroll_tax_table_id' => :'payrollTaxTableID',
        :'amount' => :'amount',
        :'payroll_deduction_type_id' => :'payrollDeductionTypeID',
        :'vendor_id' => :'vendorID',
        :'deduction_base_type' => :'deductionBaseType',
        :'deduction_type' => :'deductionType',
        :'state_id' => :'stateID',
        :'separate_check' => :'separateCheck',
        :'max_per_pay_period' => :'maxPerPayPeriod',
        :'company_paid' => :'companyPaid',
        :'w2_code' => :'w2Code',
        :'show_on_check' => :'showOnCheck',
        :'gl_account_id' => :'glAccountID',
        :'min_per_pay_period' => :'minPerPayPeriod',
        :'annual_limit' => :'annualLimit',
        :'default_employee' => :'defaultEmployee',
        :'sec125_exempt' => :'sec125Exempt'
      }
    end
  end
end

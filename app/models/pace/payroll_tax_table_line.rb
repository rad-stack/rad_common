module Pace
  class PayrollTaxTableLine < Base
    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :payroll_tax_table_line_id

    attr_accessor :up_to_amount

    attr_accessor :payroll_tax_table_id

    attr_accessor :amount

    attr_accessor :from_amount


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'payroll_tax_table_line_id' => :'payrollTaxTableLineID',
        :'up_to_amount' => :'upToAmount',
        :'payroll_tax_table_id' => :'payrollTaxTableID',
        :'amount' => :'amount',
        :'from_amount' => :'fromAmount'
      }
    end
  end
end

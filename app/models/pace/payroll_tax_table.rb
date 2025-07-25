module Pace
  class PayrollTaxTable < Base
    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :tax_code

    attr_accessor :standard_deduction_amount

    attr_accessor :dependent_deduction_amount


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'tax_code' => :'taxCode',
        :'standard_deduction_amount' => :'standardDeductionAmount',
        :'dependent_deduction_amount' => :'dependentDeductionAmount'
      }
    end
  end
end

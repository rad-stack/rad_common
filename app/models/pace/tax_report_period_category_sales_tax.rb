module Pace
  class TaxReportPeriodCategorySalesTax < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_tax

    attr_accessor :tax_base

    attr_accessor :tax

    attr_accessor :tax_report_period_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_tax' => :'salesTax',
        :'tax_base' => :'taxBase',
        :'tax' => :'tax',
        :'tax_report_period_category' => :'taxReportPeriodCategory'
      }
    end
  end
end

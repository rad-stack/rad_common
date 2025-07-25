module Pace
  class TaxReportPeriodCategory < Base
    attr_accessor :_module

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :calculation

    attr_accessor :tax_base

    attr_accessor :tax_report_category

    attr_accessor :tax

    attr_accessor :tax_report_period


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'_module' => :'module',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'calculation' => :'calculation',
        :'tax_base' => :'taxBase',
        :'tax_report_category' => :'taxReportCategory',
        :'tax' => :'tax',
        :'tax_report_period' => :'taxReportPeriod'
      }
    end
  end
end

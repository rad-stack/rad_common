module Pace
  class TaxReportPeriodMonthMapping < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :tax_report_month

    attr_accessor :tax_report_period


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'tax_report_month' => :'taxReportMonth',
        :'tax_report_period' => :'taxReportPeriod'
      }
    end
  end
end

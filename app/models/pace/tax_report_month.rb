module Pace
  class TaxReportMonth < Base
    attr_accessor :id

    attr_accessor :month

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :tax_report

    attr_accessor :tax_year

    attr_accessor :tax_reported


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'month' => :'month',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'tax_report' => :'taxReport',
        :'tax_year' => :'taxYear',
        :'tax_reported' => :'taxReported'
      }
    end
  end
end

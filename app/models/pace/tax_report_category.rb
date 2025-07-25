module Pace
  class TaxReportCategory < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :tax_report

    attr_accessor :ap_description

    attr_accessor :ap_xpath

    attr_accessor :ar_description

    attr_accessor :ar_xpath

    attr_accessor :report_category_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'tax_report' => :'taxReport',
        :'ap_description' => :'apDescription',
        :'ap_xpath' => :'apXpath',
        :'ar_description' => :'arDescription',
        :'ar_xpath' => :'arXpath',
        :'report_category_id' => :'reportCategoryId'
      }
    end
  end
end

module Pace
  class TaxReport < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :start_date

    attr_accessor :year_end

    attr_accessor :quarterly

    attr_accessor :include_ap

    attr_accessor :quarter3_end

    attr_accessor :quarter1_end

    attr_accessor :quarter2_end

    attr_accessor :monthly

    attr_accessor :yearly


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'start_date' => :'startDate',
        :'year_end' => :'yearEnd',
        :'quarterly' => :'quarterly',
        :'include_ap' => :'includeAP',
        :'quarter3_end' => :'quarter3End',
        :'quarter1_end' => :'quarter1End',
        :'quarter2_end' => :'quarter2End',
        :'monthly' => :'monthly',
        :'yearly' => :'yearly'
      }
    end
  end
end

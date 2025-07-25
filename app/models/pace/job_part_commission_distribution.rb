module Pace
  class JobPartCommissionDistribution < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sales_person

    attr_accessor :amount

    attr_accessor :commission_rate


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sales_person' => :'salesPerson',
        :'amount' => :'amount',
        :'commission_rate' => :'commissionRate'
      }
    end
  end
end

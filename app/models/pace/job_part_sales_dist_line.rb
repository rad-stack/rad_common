module Pace
  class JobPartSalesDistLine < Base
    attr_accessor :id

    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_location

    attr_accessor :job_part_sales_dist

    attr_accessor :actual_job_cost


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manufacturing_location' => :'manufacturingLocation',
        :'job_part_sales_dist' => :'jobPartSalesDist',
        :'actual_job_cost' => :'actualJobCost'
      }
    end
  end
end

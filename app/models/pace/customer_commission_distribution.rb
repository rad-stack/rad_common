module Pace
  class CustomerCommissionDistribution < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_person

    attr_accessor :customer

    attr_accessor :commission_rate


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_person' => :'salesPerson',
        :'customer' => :'customer',
        :'commission_rate' => :'commissionRate'
      }
    end
  end
end

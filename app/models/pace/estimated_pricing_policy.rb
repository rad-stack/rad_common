module Pace
  class EstimatedPricingPolicy < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :amount

    attr_accessor :customer

    attr_accessor :buffer_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'amount' => :'amount',
        :'customer' => :'customer',
        :'buffer_type' => :'bufferType'
      }
    end
  end
end

module Pace
  class ShipProvider < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :alt_name

    attr_accessor :freight_activity_code

    attr_accessor :scac

    attr_accessor :tracking_url


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'alt_name' => :'altName',
        :'freight_activity_code' => :'freightActivityCode',
        :'scac' => :'scac',
        :'tracking_url' => :'trackingUrl'
      }
    end
  end
end

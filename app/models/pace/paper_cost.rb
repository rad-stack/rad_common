module Pace
  class PaperCost < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :price

    attr_accessor :vendor

    attr_accessor :uom

    attr_accessor :manufacturing_locations

    attr_accessor :paper_size

    attr_accessor :primary_vendor


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'price' => :'price',
        :'vendor' => :'vendor',
        :'uom' => :'uom',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'paper_size' => :'paperSize',
        :'primary_vendor' => :'primaryVendor'
      }
    end
  end
end

module Pace
  class MetroAreaRelay < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_location

    attr_accessor :metro_area

    attr_accessor :hours_in_transit


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manufacturing_location' => :'manufacturingLocation',
        :'metro_area' => :'metroArea',
        :'hours_in_transit' => :'hoursInTransit'
      }
    end
  end
end

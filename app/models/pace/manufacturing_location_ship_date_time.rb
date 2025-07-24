module Pace
  class ManufacturingLocationShipDateTime < Base
    attr_accessor :id

    attr_accessor :day_of_week

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ship_via

    attr_accessor :manufacturing_location

    attr_accessor :earliest_delivery_time

    attr_accessor :cut_off_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'day_of_week' => :'dayOfWeek',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ship_via' => :'shipVia',
        :'manufacturing_location' => :'manufacturingLocation',
        :'earliest_delivery_time' => :'earliestDeliveryTime',
        :'cut_off_time' => :'cutOffTime'
      }
    end
  end
end

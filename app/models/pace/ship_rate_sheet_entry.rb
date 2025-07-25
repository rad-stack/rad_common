module Pace
  class ShipRateSheetEntry < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ship_via

    attr_accessor :from_zone

    attr_accessor :max_weight

    attr_accessor :shipping_charge

    attr_accessor :to_zone


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ship_via' => :'shipVia',
        :'from_zone' => :'fromZone',
        :'max_weight' => :'maxWeight',
        :'shipping_charge' => :'shippingCharge',
        :'to_zone' => :'toZone'
      }
    end
  end
end

module Pace
  class Lot < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :inventory_item

    attr_accessor :expiration_date

    attr_accessor :revision

    attr_accessor :qty_uom

    attr_accessor :qty_on_hand

    attr_accessor :average_cost

    attr_accessor :vendor_lot_number

    attr_accessor :lot_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'inventory_item' => :'inventoryItem',
        :'expiration_date' => :'expirationDate',
        :'revision' => :'revision',
        :'qty_uom' => :'qtyUom',
        :'qty_on_hand' => :'qtyOnHand',
        :'average_cost' => :'averageCost',
        :'vendor_lot_number' => :'vendorLotNumber',
        :'lot_number' => :'lotNumber'
      }
    end
  end
end

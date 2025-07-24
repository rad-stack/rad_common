module Pace
  class InventoryBinQuantity < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :inventory_item

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :inventory_bin_key

    attr_accessor :quantity_available

    attr_accessor :qty_on_hand

    attr_accessor :qty_on_order

    attr_accessor :qty_in_production

    attr_accessor :qty_allocated

    attr_accessor :inventory_location_quantity

    attr_accessor :recalculate


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'inventory_item' => :'inventoryItem',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'quantity_available' => :'quantityAvailable',
        :'qty_on_hand' => :'qtyOnHand',
        :'qty_on_order' => :'qtyOnOrder',
        :'qty_in_production' => :'qtyInProduction',
        :'qty_allocated' => :'qtyAllocated',
        :'inventory_location_quantity' => :'inventoryLocationQuantity',
        :'recalculate' => :'recalculate'
      }
    end
  end
end

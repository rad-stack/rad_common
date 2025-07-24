module Pace
  class InventoryLocationQuantity < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :inventory_item

    attr_accessor :last_cycle_count

    attr_accessor :inventory_location

    attr_accessor :quantity_available

    attr_accessor :qty_on_hand

    attr_accessor :minimum_stock_level

    attr_accessor :qty_on_order

    attr_accessor :qty_in_production

    attr_accessor :maximum_stock_level

    attr_accessor :qty_allocated


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'inventory_item' => :'inventoryItem',
        :'last_cycle_count' => :'lastCycleCount',
        :'inventory_location' => :'inventoryLocation',
        :'quantity_available' => :'quantityAvailable',
        :'qty_on_hand' => :'qtyOnHand',
        :'minimum_stock_level' => :'minimumStockLevel',
        :'qty_on_order' => :'qtyOnOrder',
        :'qty_in_production' => :'qtyInProduction',
        :'maximum_stock_level' => :'maximumStockLevel',
        :'qty_allocated' => :'qtyAllocated'
      }
    end
  end
end

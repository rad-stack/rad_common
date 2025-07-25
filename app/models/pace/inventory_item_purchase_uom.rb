module Pace
  class InventoryItemPurchaseUom < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :inventory_item

    attr_accessor :qty_uom

    attr_accessor :unit_quantity

    attr_accessor :purchase_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'inventory_item' => :'inventoryItem',
        :'qty_uom' => :'qtyUOM',
        :'unit_quantity' => :'unitQuantity',
        :'purchase_uom' => :'purchaseUOM'
      }
    end
  end
end

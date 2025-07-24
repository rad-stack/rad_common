module Pace
  class InventoryItemVendorCost < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :cost

    attr_accessor :up_to_quantity

    attr_accessor :carton_qty

    attr_accessor :inventory_item_vendor


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'cost' => :'cost',
        :'up_to_quantity' => :'upToQuantity',
        :'carton_qty' => :'cartonQty',
        :'inventory_item_vendor' => :'inventoryItemVendor'
      }
    end
  end
end

module Pace
  class InventoryConversionTarget < Base
    attr_accessor :id

    attr_accessor :lot

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :inventory_item

    attr_accessor :uom

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :revision

    attr_accessor :inventory_bin_key

    attr_accessor :serial_id

    attr_accessor :inventory_conversion

    attr_accessor :cost_share


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'lot' => :'lot',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'inventory_item' => :'inventoryItem',
        :'uom' => :'uom',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'revision' => :'revision',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'serial_id' => :'serialID',
        :'inventory_conversion' => :'inventoryConversion',
        :'cost_share' => :'costShare'
      }
    end
  end
end

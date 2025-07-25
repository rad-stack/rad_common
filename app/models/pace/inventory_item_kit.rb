module Pace
  class InventoryItemKit < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :quantity

    attr_accessor :inventory_item

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :revision

    attr_accessor :inventory_bin_key

    attr_accessor :quantity_available

    attr_accessor :kit_revision

    attr_accessor :kit_inventory_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'quantity' => :'quantity',
        :'inventory_item' => :'inventoryItem',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'revision' => :'revision',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'quantity_available' => :'quantityAvailable',
        :'kit_revision' => :'kitRevision',
        :'kit_inventory_item' => :'kitInventoryItem'
      }
    end
  end
end

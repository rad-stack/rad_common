module Pace
  class InventoryConversion < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :uom

    attr_accessor :inventory_bin_key

    attr_accessor :serial_id

    attr_accessor :default_pull_qty

    attr_accessor :source_inventory_location

    attr_accessor :source_inventory_bin

    attr_accessor :production_note

    attr_accessor :source_lot

    attr_accessor :convert_quantity

    attr_accessor :source_revision

    attr_accessor :source_inventory_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'uom' => :'uom',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'serial_id' => :'serialID',
        :'default_pull_qty' => :'defaultPullQty',
        :'source_inventory_location' => :'sourceInventoryLocation',
        :'source_inventory_bin' => :'sourceInventoryBin',
        :'production_note' => :'productionNote',
        :'source_lot' => :'sourceLot',
        :'convert_quantity' => :'convertQuantity',
        :'source_revision' => :'sourceRevision',
        :'source_inventory_item' => :'sourceInventoryItem'
      }
    end
  end
end

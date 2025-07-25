module Pace
  class InventoryItemManufacturingLocation < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :inventory_item

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :activity_code

    attr_accessor :make_ready_activity_code

    attr_accessor :location_bin_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'inventory_item' => :'inventoryItem',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'activity_code' => :'activityCode',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'location_bin_key' => :'locationBinKey'
      }
    end
  end
end

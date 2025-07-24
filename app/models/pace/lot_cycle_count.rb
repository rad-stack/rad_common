module Pace
  class LotCycleCount < Base
    attr_accessor :lot

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :inventory_item

    attr_accessor :inventory_bin

    attr_accessor :last_cycle_count

    attr_accessor :inventory_location


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'lot' => :'lot',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'inventory_item' => :'inventoryItem',
        :'inventory_bin' => :'inventoryBin',
        :'last_cycle_count' => :'lastCycleCount',
        :'inventory_location' => :'inventoryLocation'
      }
    end
  end
end

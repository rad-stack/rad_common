module Pace
  class InventoryItemVendor < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :lead_time

    attr_accessor :inventory_item

    attr_accessor :vendor

    attr_accessor :vendor_part_number

    attr_accessor :purchasing_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'lead_time' => :'leadTime',
        :'inventory_item' => :'inventoryItem',
        :'vendor' => :'vendor',
        :'vendor_part_number' => :'vendorPartNumber',
        :'purchasing_uom' => :'purchasingUOM'
      }
    end
  end
end

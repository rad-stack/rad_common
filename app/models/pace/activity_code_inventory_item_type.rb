module Pace
  class ActivityCodeInventoryItemType < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :activity_code

    attr_accessor :inventory_item_type

    attr_accessor :activity_pull_quantity_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'activity_code' => :'activityCode',
        :'inventory_item_type' => :'inventoryItemType',
        :'activity_pull_quantity_type' => :'activityPullQuantityType'
      }
    end
  end
end

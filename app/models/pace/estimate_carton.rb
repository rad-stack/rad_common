module Pace
  class EstimateCarton < Base
    attr_accessor :id

    attr_accessor :count

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :note

    attr_accessor :shipment

    attr_accessor :packaging_inventory_item

    attr_accessor :skid

    attr_accessor :skid_count

    attr_accessor :skid_weight

    attr_accessor :planned_quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'count' => :'count',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'note' => :'note',
        :'shipment' => :'shipment',
        :'packaging_inventory_item' => :'packagingInventoryItem',
        :'skid' => :'skid',
        :'skid_count' => :'skidCount',
        :'skid_weight' => :'skidWeight',
        :'planned_quantity' => :'plannedQuantity'
      }
    end
  end
end

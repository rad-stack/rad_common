module Pace
  class SuggestedRoll < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :cost_center

    attr_accessor :job_material

    attr_accessor :job_plan

    attr_accessor :inventory_line

    attr_accessor :serial_id

    attr_accessor :inventory_line_quantity_remaining

    attr_accessor :quantity_remaining_to_produce

    attr_accessor :group_description

    attr_accessor :inventory_line_quantity_used


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'cost_center' => :'costCenter',
        :'job_material' => :'jobMaterial',
        :'job_plan' => :'jobPlan',
        :'inventory_line' => :'inventoryLine',
        :'serial_id' => :'serialID',
        :'inventory_line_quantity_remaining' => :'inventoryLineQuantityRemaining',
        :'quantity_remaining_to_produce' => :'quantityRemainingToProduce',
        :'group_description' => :'groupDescription',
        :'inventory_line_quantity_used' => :'inventoryLineQuantityUsed'
      }
    end
  end
end

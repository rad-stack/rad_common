module Pace
  class EstimateOption < Base
    attr_accessor :id

    attr_accessor :option

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity_per_unit

    attr_accessor :press_event

    attr_accessor :finishing_operation

    attr_accessor :vendor

    attr_accessor :correlation_id

    attr_accessor :estimate_quantity

    attr_accessor :finishing_operation_material

    attr_accessor :estimate_material

    attr_accessor :option_note


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'option' => :'option',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity_per_unit' => :'quantityPerUnit',
        :'press_event' => :'pressEvent',
        :'finishing_operation' => :'finishingOperation',
        :'vendor' => :'vendor',
        :'correlation_id' => :'correlationId',
        :'estimate_quantity' => :'estimateQuantity',
        :'finishing_operation_material' => :'finishingOperationMaterial',
        :'estimate_material' => :'estimateMaterial',
        :'option_note' => :'optionNote'
      }
    end
  end
end

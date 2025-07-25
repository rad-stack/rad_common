module Pace
  class EstimateRequestOption < Base
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

    attr_accessor :finishing_operation_material

    attr_accessor :estimate_request_part

    attr_accessor :option_note

    attr_accessor :estimate_request_material


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
        :'finishing_operation_material' => :'finishingOperationMaterial',
        :'estimate_request_part' => :'estimateRequestPart',
        :'option_note' => :'optionNote',
        :'estimate_request_material' => :'estimateRequestMaterial'
      }
    end
  end
end

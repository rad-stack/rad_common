module Pace
  class EstimateRequestFinishingOp < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :units

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :finishing_operation

    attr_accessor :quantity

    attr_accessor :note

    attr_accessor :customer_viewable

    attr_accessor :quantity_forced

    attr_accessor :unit_label_forced

    attr_accessor :finishing_operation_material_quantity_forced

    attr_accessor :finishing_operation_material_quantity

    attr_accessor :qty_per_unit

    attr_accessor :numbering_start

    attr_accessor :units_forced

    attr_accessor :finishing_operation_material_forced

    attr_accessor :qty_per_unit_forced

    attr_accessor :finishing_operation_material

    attr_accessor :operation_level

    attr_accessor :in_line

    attr_accessor :estimate_request_part


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'units' => :'units',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'finishing_operation' => :'finishingOperation',
        :'quantity' => :'quantity',
        :'note' => :'note',
        :'customer_viewable' => :'customerViewable',
        :'quantity_forced' => :'quantityForced',
        :'unit_label_forced' => :'unitLabelForced',
        :'finishing_operation_material_quantity_forced' => :'finishingOperationMaterialQuantityForced',
        :'finishing_operation_material_quantity' => :'finishingOperationMaterialQuantity',
        :'qty_per_unit' => :'qtyPerUnit',
        :'numbering_start' => :'numberingStart',
        :'units_forced' => :'unitsForced',
        :'finishing_operation_material_forced' => :'finishingOperationMaterialForced',
        :'qty_per_unit_forced' => :'qtyPerUnitForced',
        :'finishing_operation_material' => :'finishingOperationMaterial',
        :'operation_level' => :'operationLevel',
        :'in_line' => :'inLine',
        :'estimate_request_part' => :'estimateRequestPart'
      }
    end
  end
end

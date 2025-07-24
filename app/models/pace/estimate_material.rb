module Pace
  class EstimateMaterial < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :weight

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :inventory_item

    attr_accessor :vendor

    attr_accessor :quantity_forced

    attr_accessor :correlation_id

    attr_accessor :estimate_quantity

    attr_accessor :include_in_additional_piece_weight

    attr_accessor :paper_type

    attr_accessor :unit_cost

    attr_accessor :fktag_inventoryitem

    attr_accessor :unit_cost_forced

    attr_accessor :estimate_item

    attr_accessor :material_total_weight


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'weight' => :'weight',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'inventory_item' => :'inventoryItem',
        :'vendor' => :'vendor',
        :'quantity_forced' => :'quantityForced',
        :'correlation_id' => :'correlationId',
        :'estimate_quantity' => :'estimateQuantity',
        :'include_in_additional_piece_weight' => :'includeInAdditionalPieceWeight',
        :'paper_type' => :'paperType',
        :'unit_cost' => :'unitCost',
        :'fktag_inventoryitem' => :'fktag_inventoryitem',
        :'unit_cost_forced' => :'unitCostForced',
        :'estimate_item' => :'estimateItem',
        :'material_total_weight' => :'materialTotalWeight'
      }
    end
  end
end

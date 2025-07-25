module Pace
  class EstimateItem < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :price

    attr_accessor :discount_amount

    attr_accessor :customer_viewable

    attr_accessor :correlation_id

    attr_accessor :estimate_quantity

    attr_accessor :unit_price

    attr_accessor :final_price_forced

    attr_accessor :unit_price_forced

    attr_accessor :flat_price_forced

    attr_accessor :final_price

    attr_accessor :price_quantity_forced

    attr_accessor :look_up_quantity

    attr_accessor :look_up_quantity_forced

    attr_accessor :price_quantity

    attr_accessor :adjusted_price

    attr_accessor :adjust_value

    attr_accessor :flat_price

    attr_accessor :quote_item_type

    attr_accessor :quote_item_type_inventory_item

    attr_accessor :quantity_override

    attr_accessor :quantity_multiplier

    attr_accessor :sides

    attr_accessor :inventory_quantity

    attr_accessor :activity_code_plq_mapping_id

    attr_accessor :adjusted_unit_price

    attr_accessor :inventory_quantity_forced

    attr_accessor :revision


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'price' => :'price',
        :'discount_amount' => :'discountAmount',
        :'customer_viewable' => :'customerViewable',
        :'correlation_id' => :'correlationId',
        :'estimate_quantity' => :'estimateQuantity',
        :'unit_price' => :'unitPrice',
        :'final_price_forced' => :'finalPriceForced',
        :'unit_price_forced' => :'unitPriceForced',
        :'flat_price_forced' => :'flatPriceForced',
        :'final_price' => :'finalPrice',
        :'price_quantity_forced' => :'priceQuantityForced',
        :'look_up_quantity' => :'lookUpQuantity',
        :'look_up_quantity_forced' => :'lookUpQuantityForced',
        :'price_quantity' => :'priceQuantity',
        :'adjusted_price' => :'adjustedPrice',
        :'adjust_value' => :'adjustValue',
        :'flat_price' => :'flatPrice',
        :'quote_item_type' => :'quoteItemType',
        :'quote_item_type_inventory_item' => :'quoteItemTypeInventoryItem',
        :'quantity_override' => :'quantityOverride',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'sides' => :'sides',
        :'inventory_quantity' => :'inventoryQuantity',
        :'activity_code_plq_mapping_id' => :'activityCodePlqMappingId',
        :'adjusted_unit_price' => :'adjustedUnitPrice',
        :'inventory_quantity_forced' => :'inventoryQuantityForced',
        :'revision' => :'revision'
      }
    end
  end
end

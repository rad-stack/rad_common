module Pace
  class JobPartItem < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :sales_category

    attr_accessor :item_template

    attr_accessor :quantity

    attr_accessor :manual

    attr_accessor :price

    attr_accessor :customer_viewable

    attr_accessor :alt_name

    attr_accessor :material_vendor

    attr_accessor :unit_price

    attr_accessor :final_price

    attr_accessor :inventory_unit_price

    attr_accessor :adjusted_price

    attr_accessor :inventory_unit_price_forced

    attr_accessor :adjust_value

    attr_accessor :flat_price

    attr_accessor :qty_ordered

    attr_accessor :quote_source

    attr_accessor :quote_item_type

    attr_accessor :quote_item_type_inventory_item

    attr_accessor :quantity_override

    attr_accessor :quantity_multiplier

    attr_accessor :quantity_value

    attr_accessor :qty_shipped

    attr_accessor :quantity_remaining

    attr_accessor :inventory_quantity

    attr_accessor :activity_code_plq_mapping_id

    attr_accessor :inventory_quantity_forced

    attr_accessor :revision

    attr_accessor :print_service

    attr_accessor :original_quantity

    attr_accessor :lock_final_price

    attr_accessor :unit_price_override

    attr_accessor :print_stream_detail_id

    attr_accessor :print_stream_detail_type

    attr_accessor :flat_price_override

    attr_accessor :inventory_qty_override


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'sales_category' => :'salesCategory',
        :'item_template' => :'itemTemplate',
        :'quantity' => :'quantity',
        :'manual' => :'manual',
        :'price' => :'price',
        :'customer_viewable' => :'customerViewable',
        :'alt_name' => :'altName',
        :'material_vendor' => :'materialVendor',
        :'unit_price' => :'unitPrice',
        :'final_price' => :'finalPrice',
        :'inventory_unit_price' => :'inventoryUnitPrice',
        :'adjusted_price' => :'adjustedPrice',
        :'inventory_unit_price_forced' => :'inventoryUnitPriceForced',
        :'adjust_value' => :'adjustValue',
        :'flat_price' => :'flatPrice',
        :'qty_ordered' => :'qtyOrdered',
        :'quote_source' => :'quoteSource',
        :'quote_item_type' => :'quoteItemType',
        :'quote_item_type_inventory_item' => :'quoteItemTypeInventoryItem',
        :'quantity_override' => :'quantityOverride',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'quantity_value' => :'quantityValue',
        :'qty_shipped' => :'qtyShipped',
        :'quantity_remaining' => :'quantityRemaining',
        :'inventory_quantity' => :'inventoryQuantity',
        :'activity_code_plq_mapping_id' => :'activityCodePlqMappingId',
        :'inventory_quantity_forced' => :'inventoryQuantityForced',
        :'revision' => :'revision',
        :'print_service' => :'printService',
        :'original_quantity' => :'originalQuantity',
        :'lock_final_price' => :'lockFinalPrice',
        :'unit_price_override' => :'unitPriceOverride',
        :'print_stream_detail_id' => :'printStreamDetailID',
        :'print_stream_detail_type' => :'printStreamDetailType',
        :'flat_price_override' => :'flatPriceOverride',
        :'inventory_qty_override' => :'inventoryQtyOverride'
      }
    end
  end
end

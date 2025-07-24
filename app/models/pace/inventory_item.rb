module Pace
  class InventoryItem < Base
    attr_accessor :id

    attr_accessor :size

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :prod_group_sub_key

    attr_accessor :product_group

    attr_accessor :sub_product_group

    attr_accessor :default_vendor

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sales_category

    attr_accessor :sales_ytd

    attr_accessor :printable_inventory_token

    attr_accessor :dsf_entity

    attr_accessor :dsf_shared

    attr_accessor :date_setup

    attr_accessor :print_stream_shared

    attr_accessor :item_template

    attr_accessor :max_weight_per_box

    attr_accessor :addl_desc

    attr_accessor :customer

    attr_accessor :size_width_display_uom

    attr_accessor :size_width

    attr_accessor :taxable

    attr_accessor :uom

    attr_accessor :inventory_bin

    attr_accessor :last_cycle_count

    attr_accessor :inventory_location

    attr_accessor :unit_price

    attr_accessor :activity_code

    attr_accessor :size_length

    attr_accessor :size_length_display_uom

    attr_accessor :make_ready_activity_code

    attr_accessor :alt_description

    attr_accessor :grain_direction

    attr_accessor :unit_weight

    attr_accessor :paper_weight

    attr_accessor :qty_uom

    attr_accessor :paper_type

    attr_accessor :mweight

    attr_accessor :quantity_available

    attr_accessor :qty_on_hand

    attr_accessor :qty_on_order

    attr_accessor :qty_in_production

    attr_accessor :qty_allocated

    attr_accessor :estimate_paper

    attr_accessor :date_last_receipt

    attr_accessor :inventory_item_type

    attr_accessor :gl_cogs_account

    attr_accessor :gl_asset_account

    attr_accessor :gl_inventory_variance_account

    attr_accessor :location_bin_key

    attr_accessor :brand

    attr_accessor :media_grade

    attr_accessor :media_color_name

    attr_accessor :carton_qty

    attr_accessor :roll_length

    attr_accessor :plq_inventory_price_method

    attr_accessor :pricing_method

    attr_accessor :additional_item_id

    attr_accessor :display_as_desc

    attr_accessor :storage_charge_per_period

    attr_accessor :pre_printed

    attr_accessor :secondary_inventory_location

    attr_accessor :inherit_tags_from_paper_weight

    attr_accessor :sent_to_plant_manager

    attr_accessor :active_serial_ids

    attr_accessor :set_count

    attr_accessor :internal_part_number

    attr_accessor :override_po_price

    attr_accessor :printable_quantity_available

    attr_accessor :max_stock_level

    attr_accessor :minimum_location_stock_level

    attr_accessor :standard_cost

    attr_accessor :corresponding_tabloid

    attr_accessor :unit_height_display_uom

    attr_accessor :do_not_auto_calc_m_weight

    attr_accessor :pod

    attr_accessor :estimate_skid

    attr_accessor :printable_product_id

    attr_accessor :last_po_master_id

    attr_accessor :po_qty_to_order

    attr_accessor :eservice_maximum_stock_level

    attr_accessor :future_quantity

    attr_accessor :analysis_class

    attr_accessor :sell_unit_qty

    attr_accessor :min_stock_level

    attr_accessor :cumulative_manufacturing_locations

    attr_accessor :replenishment_quantity

    attr_accessor :detail_uom

    attr_accessor :secondary_activity_code

    attr_accessor :ownership

    attr_accessor :visual_opening_allowance_type

    attr_accessor :damage_quantity

    attr_accessor :date_last_price_chg

    attr_accessor :freight_cost

    attr_accessor :maximum_location_stock_level

    attr_accessor :sales_mtd

    attr_accessor :build_on_the_fly_kit

    attr_accessor :replacement_cost

    attr_accessor :qty_sold_last_yr

    attr_accessor :unit_length_display_uom

    attr_accessor :unit_height

    attr_accessor :track_quantity

    attr_accessor :unit_length

    attr_accessor :qty_sold_ytd

    attr_accessor :sales_last_yr

    attr_accessor :qty_sold_mtd

    attr_accessor :last_qty_ordered

    attr_accessor :secondary_location_bin_key

    attr_accessor :related_items_validation

    attr_accessor :minimum_total_price

    attr_accessor :min_order_qty

    attr_accessor :incoming_quantity

    attr_accessor :basis

    attr_accessor :step_order_qty

    attr_accessor :default_revision

    attr_accessor :egood_message

    attr_accessor :mweight_for_metrix

    attr_accessor :max_order_qty

    attr_accessor :suggested_minimum_replenishment

    attr_accessor :brief_description

    attr_accessor :eservice_minimum_stock_level

    attr_accessor :estimate_inventory_price_method

    attr_accessor :ship_to_inventory_costing_method

    attr_accessor :unit_width

    attr_accessor :suggested_maximum_replenishment

    attr_accessor :updated_by_print_stream

    attr_accessor :shipping_exempt

    attr_accessor :show_on_auto_create_po

    attr_accessor :printable_qty_on_hand

    attr_accessor :fiery_media_id

    attr_accessor :item_status

    attr_accessor :date_last_po

    attr_accessor :secondary_inventory_bin

    attr_accessor :default_purchase_uom

    attr_accessor :estimate_carton

    attr_accessor :sell_price1

    attr_accessor :dsf_shared_via_print_stream

    attr_accessor :allow_backorders

    attr_accessor :unit_width_display_uom

    attr_accessor :eservice_quantity_available

    attr_accessor :cycle_count

    attr_accessor :average_cost


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'size' => :'size',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'prod_group_sub_key' => :'prodGroupSubKey',
        :'product_group' => :'productGroup',
        :'sub_product_group' => :'subProductGroup',
        :'default_vendor' => :'defaultVendor',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sales_category' => :'salesCategory',
        :'sales_ytd' => :'salesYTD',
        :'printable_inventory_token' => :'printableInventoryToken',
        :'dsf_entity' => :'dsfEntity',
        :'dsf_shared' => :'dsfShared',
        :'date_setup' => :'dateSetup',
        :'print_stream_shared' => :'printStreamShared',
        :'item_template' => :'itemTemplate',
        :'max_weight_per_box' => :'maxWeightPerBox',
        :'addl_desc' => :'addlDesc',
        :'customer' => :'customer',
        :'size_width_display_uom' => :'sizeWidthDisplayUOM',
        :'size_width' => :'sizeWidth',
        :'taxable' => :'taxable',
        :'uom' => :'uom',
        :'inventory_bin' => :'inventoryBin',
        :'last_cycle_count' => :'lastCycleCount',
        :'inventory_location' => :'inventoryLocation',
        :'unit_price' => :'unitPrice',
        :'activity_code' => :'activityCode',
        :'size_length' => :'sizeLength',
        :'size_length_display_uom' => :'sizeLengthDisplayUOM',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'alt_description' => :'altDescription',
        :'grain_direction' => :'grainDirection',
        :'unit_weight' => :'unitWeight',
        :'paper_weight' => :'paperWeight',
        :'qty_uom' => :'qtyUom',
        :'paper_type' => :'paperType',
        :'mweight' => :'mweight',
        :'quantity_available' => :'quantityAvailable',
        :'qty_on_hand' => :'qtyOnHand',
        :'qty_on_order' => :'qtyOnOrder',
        :'qty_in_production' => :'qtyInProduction',
        :'qty_allocated' => :'qtyAllocated',
        :'estimate_paper' => :'estimatePaper',
        :'date_last_receipt' => :'dateLastReceipt',
        :'inventory_item_type' => :'inventoryItemType',
        :'gl_cogs_account' => :'glCogsAccount',
        :'gl_asset_account' => :'glAssetAccount',
        :'gl_inventory_variance_account' => :'glInventoryVarianceAccount',
        :'location_bin_key' => :'locationBinKey',
        :'brand' => :'brand',
        :'media_grade' => :'mediaGrade',
        :'media_color_name' => :'mediaColorName',
        :'carton_qty' => :'cartonQty',
        :'roll_length' => :'rollLength',
        :'plq_inventory_price_method' => :'plqInventoryPriceMethod',
        :'pricing_method' => :'pricingMethod',
        :'additional_item_id' => :'additionalItemID',
        :'display_as_desc' => :'displayAsDesc',
        :'storage_charge_per_period' => :'storageChargePerPeriod',
        :'pre_printed' => :'prePrinted',
        :'secondary_inventory_location' => :'secondaryInventoryLocation',
        :'inherit_tags_from_paper_weight' => :'inheritTagsFromPaperWeight',
        :'sent_to_plant_manager' => :'sentToPlantManager',
        :'active_serial_ids' => :'activeSerialIDs',
        :'set_count' => :'setCount',
        :'internal_part_number' => :'internalPartNumber',
        :'override_po_price' => :'overridePOPrice',
        :'printable_quantity_available' => :'printableQuantityAvailable',
        :'max_stock_level' => :'maxStockLevel',
        :'minimum_location_stock_level' => :'minimumLocationStockLevel',
        :'standard_cost' => :'standardCost',
        :'corresponding_tabloid' => :'correspondingTabloid',
        :'unit_height_display_uom' => :'unitHeightDisplayUOM',
        :'do_not_auto_calc_m_weight' => :'doNotAutoCalcMWeight',
        :'pod' => :'pod',
        :'estimate_skid' => :'estimateSkid',
        :'printable_product_id' => :'printableProductId',
        :'last_po_master_id' => :'lastPOMasterID',
        :'po_qty_to_order' => :'poQtyToOrder',
        :'eservice_maximum_stock_level' => :'eserviceMaximumStockLevel',
        :'future_quantity' => :'futureQuantity',
        :'analysis_class' => :'analysisClass',
        :'sell_unit_qty' => :'sellUnitQty',
        :'min_stock_level' => :'minStockLevel',
        :'cumulative_manufacturing_locations' => :'cumulativeManufacturingLocations',
        :'replenishment_quantity' => :'replenishmentQuantity',
        :'detail_uom' => :'detailUOM',
        :'secondary_activity_code' => :'secondaryActivityCode',
        :'ownership' => :'ownership',
        :'visual_opening_allowance_type' => :'visualOpeningAllowanceType',
        :'damage_quantity' => :'damageQuantity',
        :'date_last_price_chg' => :'dateLastPriceChg',
        :'freight_cost' => :'freightCost',
        :'maximum_location_stock_level' => :'maximumLocationStockLevel',
        :'sales_mtd' => :'salesMTD',
        :'build_on_the_fly_kit' => :'buildOnTheFlyKit',
        :'replacement_cost' => :'replacementCost',
        :'qty_sold_last_yr' => :'qtySoldLastYr',
        :'unit_length_display_uom' => :'unitLengthDisplayUOM',
        :'unit_height' => :'unitHeight',
        :'track_quantity' => :'trackQuantity',
        :'unit_length' => :'unitLength',
        :'qty_sold_ytd' => :'qtySoldYTD',
        :'sales_last_yr' => :'salesLastYr',
        :'qty_sold_mtd' => :'qtySoldMTD',
        :'last_qty_ordered' => :'lastQtyOrdered',
        :'secondary_location_bin_key' => :'secondaryLocationBinKey',
        :'related_items_validation' => :'relatedItemsValidation',
        :'minimum_total_price' => :'minimumTotalPrice',
        :'min_order_qty' => :'minOrderQty',
        :'incoming_quantity' => :'incomingQuantity',
        :'basis' => :'basis',
        :'step_order_qty' => :'stepOrderQty',
        :'default_revision' => :'defaultRevision',
        :'egood_message' => :'egoodMessage',
        :'mweight_for_metrix' => :'mweightForMetrix',
        :'max_order_qty' => :'maxOrderQty',
        :'suggested_minimum_replenishment' => :'suggestedMinimumReplenishment',
        :'brief_description' => :'briefDescription',
        :'eservice_minimum_stock_level' => :'eserviceMinimumStockLevel',
        :'estimate_inventory_price_method' => :'estimateInventoryPriceMethod',
        :'ship_to_inventory_costing_method' => :'shipToInventoryCostingMethod',
        :'unit_width' => :'unitWidth',
        :'suggested_maximum_replenishment' => :'suggestedMaximumReplenishment',
        :'updated_by_print_stream' => :'updatedByPrintStream',
        :'shipping_exempt' => :'shippingExempt',
        :'show_on_auto_create_po' => :'showOnAutoCreatePO',
        :'printable_qty_on_hand' => :'printableQtyOnHand',
        :'fiery_media_id' => :'fieryMediaId',
        :'item_status' => :'itemStatus',
        :'date_last_po' => :'dateLastPO',
        :'secondary_inventory_bin' => :'secondaryInventoryBin',
        :'default_purchase_uom' => :'defaultPurchaseUOM',
        :'estimate_carton' => :'estimateCarton',
        :'sell_price1' => :'sellPrice1',
        :'dsf_shared_via_print_stream' => :'dsfSharedViaPrintStream',
        :'allow_backorders' => :'allowBackorders',
        :'unit_width_display_uom' => :'unitWidthDisplayUOM',
        :'eservice_quantity_available' => :'eserviceQuantityAvailable',
        :'cycle_count' => :'cycleCount',
        :'average_cost' => :'averageCost'
      }
    end
  end
end

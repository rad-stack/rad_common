module Pace
  class EstimatePaper < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :certification_authority

    attr_accessor :certification_level

    attr_accessor :paper_markup

    attr_accessor :inventory_item

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :correlation_id

    attr_accessor :estimate_quantity

    attr_accessor :uom

    attr_accessor :paper_markup_forced

    attr_accessor :total_weight

    attr_accessor :alt_description

    attr_accessor :grain_direction

    attr_accessor :total_cost

    attr_accessor :buy_size_width

    attr_accessor :buy_size_height_display_uom

    attr_accessor :buy_size_width_display_uom

    attr_accessor :buy_size_height

    attr_accessor :paper_weight

    attr_accessor :qty_uom

    attr_accessor :stock_number

    attr_accessor :grain_direction_forced

    attr_accessor :planned_quantity

    attr_accessor :vendor_paper

    attr_accessor :fktag_inventoryitem

    attr_accessor :sheeting_length

    attr_accessor :fktag_paperweight

    attr_accessor :round_sheets_to

    attr_accessor :round_sheets_to_forced

    attr_accessor :sheeting_length_display_uom

    attr_accessor :paper_quoted_price

    attr_accessor :vendor_paper_vendor

    attr_accessor :paper_source_forced

    attr_accessor :paper_quote_num

    attr_accessor :paper_price

    attr_accessor :paper_source

    attr_accessor :paper_price_forced

    attr_accessor :material_type

    attr_accessor :roll_length

    attr_accessor :total_height

    attr_accessor :availability_info

    attr_accessor :paper_m_weight_for_metrix

    attr_accessor :exclude_from_finishing

    attr_accessor :planned_quantity_in_sheets

    attr_accessor :additional_metrix_sheet

    attr_accessor :partial_sheet_costing

    attr_accessor :target_uom

    attr_accessor :paper_m_weight

    attr_accessor :non_make_ready_cost

    attr_accessor :roll_length_forced

    attr_accessor :make_ready_planned_quantity_uom

    attr_accessor :net_weight

    attr_accessor :paper_buy_utilization

    attr_accessor :total_weight_uom

    attr_accessor :paper_m_weight_forced

    attr_accessor :forced_buy_size

    attr_accessor :make_ready_cost

    attr_accessor :paper_m_weight_for_metrix_forced

    attr_accessor :paper_run_utilization

    attr_accessor :make_ready_weight

    attr_accessor :planned_quantity_forced

    attr_accessor :make_ready_weight_uom

    attr_accessor :make_ready_planned_quantity

    attr_accessor :make_ready_planned_quantity_forced

    attr_accessor :inventory_item_cost


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'certification_authority' => :'certificationAuthority',
        :'certification_level' => :'certificationLevel',
        :'paper_markup' => :'paperMarkup',
        :'inventory_item' => :'inventoryItem',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'correlation_id' => :'correlationId',
        :'estimate_quantity' => :'estimateQuantity',
        :'uom' => :'uom',
        :'paper_markup_forced' => :'paperMarkupForced',
        :'total_weight' => :'totalWeight',
        :'alt_description' => :'altDescription',
        :'grain_direction' => :'grainDirection',
        :'total_cost' => :'totalCost',
        :'buy_size_width' => :'buySizeWidth',
        :'buy_size_height_display_uom' => :'buySizeHeightDisplayUOM',
        :'buy_size_width_display_uom' => :'buySizeWidthDisplayUOM',
        :'buy_size_height' => :'buySizeHeight',
        :'paper_weight' => :'paperWeight',
        :'qty_uom' => :'qtyUom',
        :'stock_number' => :'stockNumber',
        :'grain_direction_forced' => :'grainDirectionForced',
        :'planned_quantity' => :'plannedQuantity',
        :'vendor_paper' => :'vendorPaper',
        :'fktag_inventoryitem' => :'fktag_inventoryitem',
        :'sheeting_length' => :'sheetingLength',
        :'fktag_paperweight' => :'fktag_paperweight',
        :'round_sheets_to' => :'roundSheetsTo',
        :'round_sheets_to_forced' => :'roundSheetsToForced',
        :'sheeting_length_display_uom' => :'sheetingLengthDisplayUOM',
        :'paper_quoted_price' => :'paperQuotedPrice',
        :'vendor_paper_vendor' => :'vendorPaperVendor',
        :'paper_source_forced' => :'paperSourceForced',
        :'paper_quote_num' => :'paperQuoteNum',
        :'paper_price' => :'paperPrice',
        :'paper_source' => :'paperSource',
        :'paper_price_forced' => :'paperPriceForced',
        :'material_type' => :'materialType',
        :'roll_length' => :'rollLength',
        :'total_height' => :'totalHeight',
        :'availability_info' => :'availabilityInfo',
        :'paper_m_weight_for_metrix' => :'paperMWeightForMetrix',
        :'exclude_from_finishing' => :'excludeFromFinishing',
        :'planned_quantity_in_sheets' => :'plannedQuantityInSheets',
        :'additional_metrix_sheet' => :'additionalMetrixSheet',
        :'partial_sheet_costing' => :'partialSheetCosting',
        :'target_uom' => :'targetUom',
        :'paper_m_weight' => :'paperMWeight',
        :'non_make_ready_cost' => :'nonMakeReadyCost',
        :'roll_length_forced' => :'rollLengthForced',
        :'make_ready_planned_quantity_uom' => :'makeReadyPlannedQuantityUom',
        :'net_weight' => :'netWeight',
        :'paper_buy_utilization' => :'paperBuyUtilization',
        :'total_weight_uom' => :'totalWeightUom',
        :'paper_m_weight_forced' => :'paperMWeightForced',
        :'forced_buy_size' => :'forcedBuySize',
        :'make_ready_cost' => :'makeReadyCost',
        :'paper_m_weight_for_metrix_forced' => :'paperMWeightForMetrixForced',
        :'paper_run_utilization' => :'paperRunUtilization',
        :'make_ready_weight' => :'makeReadyWeight',
        :'planned_quantity_forced' => :'plannedQuantityForced',
        :'make_ready_weight_uom' => :'makeReadyWeightUom',
        :'make_ready_planned_quantity' => :'makeReadyPlannedQuantity',
        :'make_ready_planned_quantity_forced' => :'makeReadyPlannedQuantityForced',
        :'inventory_item_cost' => :'inventoryItemCost'
      }
    end
  end
end

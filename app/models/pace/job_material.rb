module Pace
  class JobMaterial < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :weight

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :manual

    attr_accessor :inventory_item

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :vendor

    attr_accessor :alt_currency_rate_source

    attr_accessor :uom

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :job_part_item

    attr_accessor :additional_description

    attr_accessor :unit_price

    attr_accessor :activity_code

    attr_accessor :quote_source

    attr_accessor :grain_direction

    attr_accessor :run_size_width

    attr_accessor :qty_shipped

    attr_accessor :run_size

    attr_accessor :quantity_remaining

    attr_accessor :printable_order_detail_id

    attr_accessor :run_size_width_display_uom

    attr_accessor :job_contact

    attr_accessor :from_estimating

    attr_accessor :buy_size_width

    attr_accessor :buy_size_width_display_uom

    attr_accessor :paper_weight

    attr_accessor :paper

    attr_accessor :run_size_grain_direction

    attr_accessor :revision

    attr_accessor :qty_uom

    attr_accessor :paper_type

    attr_accessor :stock_number

    attr_accessor :date_required

    attr_accessor :serial_id

    attr_accessor :mweight

    attr_accessor :ordered

    attr_accessor :ink

    attr_accessor :thickness

    attr_accessor :planned_quantity

    attr_accessor :shipped

    attr_accessor :pick_ticket_id

    attr_accessor :run_size_length_display_uom

    attr_accessor :run_size_length

    attr_accessor :location_bin_key

    attr_accessor :pulled_quantity

    attr_accessor :buy_size_length

    attr_accessor :sell_price

    attr_accessor :total_pounds

    attr_accessor :cover

    attr_accessor :total_kilograms

    attr_accessor :thickness_uom

    attr_accessor :vendor_paper

    attr_accessor :qty_per_kit

    attr_accessor :purchased_quantity

    attr_accessor :planned_pick_quantity

    attr_accessor :press_link

    attr_accessor :brand

    attr_accessor :media_grade

    attr_accessor :stock_pull_quantity

    attr_accessor :media_color_name

    attr_accessor :weight_remaining_certification

    attr_accessor :invoiced

    attr_accessor :fktag_inventoryitem

    attr_accessor :sheeting_length

    attr_accessor :fktag_paperweight

    attr_accessor :buy_size

    attr_accessor :fin_goods_order

    attr_accessor :buy_size_length_display_uom

    attr_accessor :re_submit_mdff_order_flag

    attr_accessor :weight_shipped_certification

    attr_accessor :mweight_forced

    attr_accessor :weight_waste_certification

    attr_accessor :round_sheets_to

    attr_accessor :round_sheets_to_forced

    attr_accessor :sheeting_length_display_uom

    attr_accessor :reviewed_for_po

    attr_accessor :press_sheets_from_buy_sheet


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'weight' => :'weight',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'manual' => :'manual',
        :'inventory_item' => :'inventoryItem',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'vendor' => :'vendor',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'uom' => :'uom',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'job_part_item' => :'jobPartItem',
        :'additional_description' => :'additionalDescription',
        :'unit_price' => :'unitPrice',
        :'activity_code' => :'activityCode',
        :'quote_source' => :'quoteSource',
        :'grain_direction' => :'grainDirection',
        :'run_size_width' => :'runSizeWidth',
        :'qty_shipped' => :'qtyShipped',
        :'run_size' => :'runSize',
        :'quantity_remaining' => :'quantityRemaining',
        :'printable_order_detail_id' => :'printableOrderDetailID',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'job_contact' => :'jobContact',
        :'from_estimating' => :'fromEstimating',
        :'buy_size_width' => :'buySizeWidth',
        :'buy_size_width_display_uom' => :'buySizeWidthDisplayUOM',
        :'paper_weight' => :'paperWeight',
        :'paper' => :'paper',
        :'run_size_grain_direction' => :'runSizeGrainDirection',
        :'revision' => :'revision',
        :'qty_uom' => :'qtyUom',
        :'paper_type' => :'paperType',
        :'stock_number' => :'stockNumber',
        :'date_required' => :'dateRequired',
        :'serial_id' => :'serialID',
        :'mweight' => :'mweight',
        :'ordered' => :'ordered',
        :'ink' => :'ink',
        :'thickness' => :'thickness',
        :'planned_quantity' => :'plannedQuantity',
        :'shipped' => :'shipped',
        :'pick_ticket_id' => :'pickTicketId',
        :'run_size_length_display_uom' => :'runSizeLengthDisplayUOM',
        :'run_size_length' => :'runSizeLength',
        :'location_bin_key' => :'locationBinKey',
        :'pulled_quantity' => :'pulledQuantity',
        :'buy_size_length' => :'buySizeLength',
        :'sell_price' => :'sellPrice',
        :'total_pounds' => :'totalPounds',
        :'cover' => :'cover',
        :'total_kilograms' => :'totalKilograms',
        :'thickness_uom' => :'thicknessUOM',
        :'vendor_paper' => :'vendorPaper',
        :'qty_per_kit' => :'qtyPerKit',
        :'purchased_quantity' => :'purchasedQuantity',
        :'planned_pick_quantity' => :'plannedPickQuantity',
        :'press_link' => :'pressLink',
        :'brand' => :'brand',
        :'media_grade' => :'mediaGrade',
        :'stock_pull_quantity' => :'stockPullQuantity',
        :'media_color_name' => :'mediaColorName',
        :'weight_remaining_certification' => :'weightRemainingCertification',
        :'invoiced' => :'invoiced',
        :'fktag_inventoryitem' => :'fktag_inventoryitem',
        :'sheeting_length' => :'sheetingLength',
        :'fktag_paperweight' => :'fktag_paperweight',
        :'buy_size' => :'buySize',
        :'fin_goods_order' => :'finGoodsOrder',
        :'buy_size_length_display_uom' => :'buySizeLengthDisplayUOM',
        :'re_submit_mdff_order_flag' => :'reSubmitMdffOrderFlag',
        :'weight_shipped_certification' => :'weightShippedCertification',
        :'mweight_forced' => :'mweightForced',
        :'weight_waste_certification' => :'weightWasteCertification',
        :'round_sheets_to' => :'roundSheetsTo',
        :'round_sheets_to_forced' => :'roundSheetsToForced',
        :'sheeting_length_display_uom' => :'sheetingLengthDisplayUOM',
        :'reviewed_for_po' => :'reviewedForPO',
        :'press_sheets_from_buy_sheet' => :'pressSheetsFromBuySheet'
      }
    end
  end
end

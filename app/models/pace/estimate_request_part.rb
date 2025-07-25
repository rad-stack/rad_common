module Pace
  class EstimateRequestPart < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :colors_side1

    attr_accessor :include_mailing

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :ink_coverage_back

    attr_accessor :sequence

    attr_accessor :sales_category

    attr_accessor :certification_authority

    attr_accessor :overall_sell_markup

    attr_accessor :overall_markup

    attr_accessor :certification_level

    attr_accessor :price_list

    attr_accessor :outside_purchase_markup

    attr_accessor :manufacturing_location

    attr_accessor :item_template

    attr_accessor :inventory_item

    attr_accessor :price_level

    attr_accessor :outside_purchase_markup_forced

    attr_accessor :uom

    attr_accessor :overall_sell_markup_forced

    attr_accessor :overall_markup_forced

    attr_accessor :outside_purchase_workflow

    attr_accessor :production_type

    attr_accessor :additional_description

    attr_accessor :user_interface_set

    attr_accessor :total_pages

    attr_accessor :final_size_w

    attr_accessor :final_size_w_display_uom

    attr_accessor :final_size_h

    attr_accessor :num_sigs

    attr_accessor :final_size_h_display_uom

    attr_accessor :estimate_request_product

    attr_accessor :total_colors

    attr_accessor :speed_factor

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :metrix_enabled

    attr_accessor :estimate_request

    attr_accessor :commission_rate

    attr_accessor :odd_panel_spine_size

    attr_accessor :fold_pattern_key

    attr_accessor :virtual_printer

    attr_accessor :fold_pattern

    attr_accessor :print_run_method

    attr_accessor :pattern_category

    attr_accessor :press_event_workflow

    attr_accessor :coating

    attr_accessor :varnish

    attr_accessor :odd_panel_width_size

    attr_accessor :num_odd_panels_spine

    attr_accessor :num_odd_panels_width

    attr_accessor :shipping_workflow

    attr_accessor :spine_size

    attr_accessor :non_image_face

    attr_accessor :bleeds_across

    attr_accessor :bleeds_along

    attr_accessor :gripper_color_bar

    attr_accessor :non_image_foot

    attr_accessor :non_image_foot_display_uom

    attr_accessor :trim_face

    attr_accessor :bleeds_foot

    attr_accessor :trim_foot

    attr_accessor :tab_head

    attr_accessor :non_image_face_display_uom

    attr_accessor :visual_opening_face

    attr_accessor :grain_specifications

    attr_accessor :tab_spine

    attr_accessor :visual_opening_foot

    attr_accessor :jog_side

    attr_accessor :bleeds_face

    attr_accessor :non_image_spine

    attr_accessor :tab_face

    attr_accessor :seam_direction

    attr_accessor :non_image_spine_display_uom

    attr_accessor :visual_opening_size_height

    attr_accessor :tab_foot

    attr_accessor :trim_head

    attr_accessor :margin_right

    attr_accessor :trim_spine

    attr_accessor :bleeds_head

    attr_accessor :bleeds_spine

    attr_accessor :prepress_workflow

    attr_accessor :visual_opening_spine

    attr_accessor :tile_product

    attr_accessor :binding_side

    attr_accessor :gangable

    attr_accessor :jog_trim

    attr_accessor :jog_trim_display_uom

    attr_accessor :next_sequence

    attr_accessor :non_image_head

    attr_accessor :non_image_head_display_uom

    attr_accessor :margin_bottom

    attr_accessor :visual_opening_size_width

    attr_accessor :margin_bottom_display_uom

    attr_accessor :num_plies

    attr_accessor :job_product_type

    attr_accessor :component_description

    attr_accessor :margin_right_display_uom

    attr_accessor :visual_opening_head

    attr_accessor :difficulty

    attr_accessor :standard_paper_type

    attr_accessor :paper_weight

    attr_accessor :run_size_grain_direction

    attr_accessor :each_of_pricing

    attr_accessor :coating_sides

    attr_accessor :paper_type

    attr_accessor :stock_number

    attr_accessor :num_pages

    attr_accessor :print_run_method_forced

    attr_accessor :ink_coverage_front_specify

    attr_accessor :ink_coverage_front

    attr_accessor :ink_default

    attr_accessor :varnish_dry

    attr_accessor :press_ink_type

    attr_accessor :coating_dry

    attr_accessor :varnish_sides

    attr_accessor :ink_coverage_back_specify

    attr_accessor :quantity10

    attr_accessor :quantity1

    attr_accessor :quantity2

    attr_accessor :quantity7

    attr_accessor :quantity8

    attr_accessor :quantity9

    attr_accessor :quantity3

    attr_accessor :quantity4

    attr_accessor :quantity5

    attr_accessor :quantity6

    attr_accessor :product_type

    attr_accessor :price_level_forced

    attr_accessor :num_short_panels_width

    attr_accessor :item_discount_percent_forced

    attr_accessor :binding_method

    attr_accessor :num_short_panels_spine

    attr_accessor :item_discount_percent

    attr_accessor :vendor_paper

    attr_accessor :fktag_inventoryitem

    attr_accessor :fktag_paperweight

    attr_accessor :trim_size_h_display_uom

    attr_accessor :questionnaire_part

    attr_accessor :primary_press_forced

    attr_accessor :run_size_w_display_uom

    attr_accessor :trim_size_w

    attr_accessor :quantity9_desc

    attr_accessor :paper_quoted_price

    attr_accessor :trim_size_w_display_uom

    attr_accessor :trim_size_h

    attr_accessor :run_size_h_display_uom

    attr_accessor :buy_size_h

    attr_accessor :commission_rate_forced

    attr_accessor :quantity7_desc

    attr_accessor :buy_size_w

    attr_accessor :vendor_paper_vendor

    attr_accessor :run_size_w

    attr_accessor :quantity4_desc

    attr_accessor :combo_percent

    attr_accessor :paper_source_forced

    attr_accessor :quantity10_desc

    attr_accessor :run_size_h

    attr_accessor :quantity2_desc

    attr_accessor :buy_size_grain_direction

    attr_accessor :paper_quote_num

    attr_accessor :quantity1_desc

    attr_accessor :paper_price

    attr_accessor :primary_press

    attr_accessor :quantity8_desc

    attr_accessor :buy_size_w_display_uom

    attr_accessor :paper_description

    attr_accessor :quantity6_desc

    attr_accessor :run_size_grain_direction_forced

    attr_accessor :buy_size_grain_direction_forced

    attr_accessor :quantity5_desc

    attr_accessor :buy_size_h_display_uom

    attr_accessor :paper_source

    attr_accessor :paper_price_forced

    attr_accessor :alt_currency_paper

    attr_accessor :combo_percent_forced

    attr_accessor :material_type

    attr_accessor :quantity3_desc


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'colors_side1' => :'colorsSide1',
        :'include_mailing' => :'includeMailing',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'ink_coverage_back' => :'inkCoverageBack',
        :'sequence' => :'sequence',
        :'sales_category' => :'salesCategory',
        :'certification_authority' => :'certificationAuthority',
        :'overall_sell_markup' => :'overallSellMarkup',
        :'overall_markup' => :'overallMarkup',
        :'certification_level' => :'certificationLevel',
        :'price_list' => :'priceList',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'manufacturing_location' => :'manufacturingLocation',
        :'item_template' => :'itemTemplate',
        :'inventory_item' => :'inventoryItem',
        :'price_level' => :'priceLevel',
        :'outside_purchase_markup_forced' => :'outsidePurchaseMarkupForced',
        :'uom' => :'uom',
        :'overall_sell_markup_forced' => :'overallSellMarkupForced',
        :'overall_markup_forced' => :'overallMarkupForced',
        :'outside_purchase_workflow' => :'outsidePurchaseWorkflow',
        :'production_type' => :'productionType',
        :'additional_description' => :'additionalDescription',
        :'user_interface_set' => :'userInterfaceSet',
        :'total_pages' => :'totalPages',
        :'final_size_w' => :'finalSizeW',
        :'final_size_w_display_uom' => :'finalSizeWDisplayUOM',
        :'final_size_h' => :'finalSizeH',
        :'num_sigs' => :'numSigs',
        :'final_size_h_display_uom' => :'finalSizeHDisplayUOM',
        :'estimate_request_product' => :'estimateRequestProduct',
        :'total_colors' => :'totalColors',
        :'speed_factor' => :'speedFactor',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'metrix_enabled' => :'metrixEnabled',
        :'estimate_request' => :'estimateRequest',
        :'commission_rate' => :'commissionRate',
        :'odd_panel_spine_size' => :'oddPanelSpineSize',
        :'fold_pattern_key' => :'foldPatternKey',
        :'virtual_printer' => :'virtualPrinter',
        :'fold_pattern' => :'foldPattern',
        :'print_run_method' => :'printRunMethod',
        :'pattern_category' => :'patternCategory',
        :'press_event_workflow' => :'pressEventWorkflow',
        :'coating' => :'coating',
        :'varnish' => :'varnish',
        :'odd_panel_width_size' => :'oddPanelWidthSize',
        :'num_odd_panels_spine' => :'numOddPanelsSpine',
        :'num_odd_panels_width' => :'numOddPanelsWidth',
        :'shipping_workflow' => :'shippingWorkflow',
        :'spine_size' => :'spineSize',
        :'non_image_face' => :'nonImageFace',
        :'bleeds_across' => :'bleedsAcross',
        :'bleeds_along' => :'bleedsAlong',
        :'gripper_color_bar' => :'gripperColorBar',
        :'non_image_foot' => :'nonImageFoot',
        :'non_image_foot_display_uom' => :'nonImageFootDisplayUOM',
        :'trim_face' => :'trimFace',
        :'bleeds_foot' => :'bleedsFoot',
        :'trim_foot' => :'trimFoot',
        :'tab_head' => :'tabHead',
        :'non_image_face_display_uom' => :'nonImageFaceDisplayUOM',
        :'visual_opening_face' => :'visualOpeningFace',
        :'grain_specifications' => :'grainSpecifications',
        :'tab_spine' => :'tabSpine',
        :'visual_opening_foot' => :'visualOpeningFoot',
        :'jog_side' => :'jogSide',
        :'bleeds_face' => :'bleedsFace',
        :'non_image_spine' => :'nonImageSpine',
        :'tab_face' => :'tabFace',
        :'seam_direction' => :'seamDirection',
        :'non_image_spine_display_uom' => :'nonImageSpineDisplayUOM',
        :'visual_opening_size_height' => :'visualOpeningSizeHeight',
        :'tab_foot' => :'tabFoot',
        :'trim_head' => :'trimHead',
        :'margin_right' => :'marginRight',
        :'trim_spine' => :'trimSpine',
        :'bleeds_head' => :'bleedsHead',
        :'bleeds_spine' => :'bleedsSpine',
        :'prepress_workflow' => :'prepressWorkflow',
        :'visual_opening_spine' => :'visualOpeningSpine',
        :'tile_product' => :'tileProduct',
        :'binding_side' => :'bindingSide',
        :'gangable' => :'gangable',
        :'jog_trim' => :'jogTrim',
        :'jog_trim_display_uom' => :'jogTrimDisplayUOM',
        :'next_sequence' => :'nextSequence',
        :'non_image_head' => :'nonImageHead',
        :'non_image_head_display_uom' => :'nonImageHeadDisplayUOM',
        :'margin_bottom' => :'marginBottom',
        :'visual_opening_size_width' => :'visualOpeningSizeWidth',
        :'margin_bottom_display_uom' => :'marginBottomDisplayUOM',
        :'num_plies' => :'numPlies',
        :'job_product_type' => :'jobProductType',
        :'component_description' => :'componentDescription',
        :'margin_right_display_uom' => :'marginRightDisplayUOM',
        :'visual_opening_head' => :'visualOpeningHead',
        :'difficulty' => :'difficulty',
        :'standard_paper_type' => :'standardPaperType',
        :'paper_weight' => :'paperWeight',
        :'run_size_grain_direction' => :'runSizeGrainDirection',
        :'each_of_pricing' => :'eachOfPricing',
        :'coating_sides' => :'coatingSides',
        :'paper_type' => :'paperType',
        :'stock_number' => :'stockNumber',
        :'num_pages' => :'numPages',
        :'print_run_method_forced' => :'printRunMethodForced',
        :'ink_coverage_front_specify' => :'inkCoverageFrontSpecify',
        :'ink_coverage_front' => :'inkCoverageFront',
        :'ink_default' => :'inkDefault',
        :'varnish_dry' => :'varnishDry',
        :'press_ink_type' => :'pressInkType',
        :'coating_dry' => :'coatingDry',
        :'varnish_sides' => :'varnishSides',
        :'ink_coverage_back_specify' => :'inkCoverageBackSpecify',
        :'quantity10' => :'quantity10',
        :'quantity1' => :'quantity1',
        :'quantity2' => :'quantity2',
        :'quantity7' => :'quantity7',
        :'quantity8' => :'quantity8',
        :'quantity9' => :'quantity9',
        :'quantity3' => :'quantity3',
        :'quantity4' => :'quantity4',
        :'quantity5' => :'quantity5',
        :'quantity6' => :'quantity6',
        :'product_type' => :'productType',
        :'price_level_forced' => :'priceLevelForced',
        :'num_short_panels_width' => :'numShortPanelsWidth',
        :'item_discount_percent_forced' => :'itemDiscountPercentForced',
        :'binding_method' => :'bindingMethod',
        :'num_short_panels_spine' => :'numShortPanelsSpine',
        :'item_discount_percent' => :'itemDiscountPercent',
        :'vendor_paper' => :'vendorPaper',
        :'fktag_inventoryitem' => :'fktag_inventoryitem',
        :'fktag_paperweight' => :'fktag_paperweight',
        :'trim_size_h_display_uom' => :'trimSizeHDisplayUOM',
        :'questionnaire_part' => :'questionnairePart',
        :'primary_press_forced' => :'primaryPressForced',
        :'run_size_w_display_uom' => :'runSizeWDisplayUOM',
        :'trim_size_w' => :'trimSizeW',
        :'quantity9_desc' => :'quantity9Desc',
        :'paper_quoted_price' => :'paperQuotedPrice',
        :'trim_size_w_display_uom' => :'trimSizeWDisplayUOM',
        :'trim_size_h' => :'trimSizeH',
        :'run_size_h_display_uom' => :'runSizeHDisplayUOM',
        :'buy_size_h' => :'buySizeH',
        :'commission_rate_forced' => :'commissionRateForced',
        :'quantity7_desc' => :'quantity7Desc',
        :'buy_size_w' => :'buySizeW',
        :'vendor_paper_vendor' => :'vendorPaperVendor',
        :'run_size_w' => :'runSizeW',
        :'quantity4_desc' => :'quantity4Desc',
        :'combo_percent' => :'comboPercent',
        :'paper_source_forced' => :'paperSourceForced',
        :'quantity10_desc' => :'quantity10Desc',
        :'run_size_h' => :'runSizeH',
        :'quantity2_desc' => :'quantity2Desc',
        :'buy_size_grain_direction' => :'buySizeGrainDirection',
        :'paper_quote_num' => :'paperQuoteNum',
        :'quantity1_desc' => :'quantity1Desc',
        :'paper_price' => :'paperPrice',
        :'primary_press' => :'primaryPress',
        :'quantity8_desc' => :'quantity8Desc',
        :'buy_size_w_display_uom' => :'buySizeWDisplayUOM',
        :'paper_description' => :'paperDescription',
        :'quantity6_desc' => :'quantity6Desc',
        :'run_size_grain_direction_forced' => :'runSizeGrainDirectionForced',
        :'buy_size_grain_direction_forced' => :'buySizeGrainDirectionForced',
        :'quantity5_desc' => :'quantity5Desc',
        :'buy_size_h_display_uom' => :'buySizeHDisplayUOM',
        :'paper_source' => :'paperSource',
        :'paper_price_forced' => :'paperPriceForced',
        :'alt_currency_paper' => :'altCurrencyPaper',
        :'combo_percent_forced' => :'comboPercentForced',
        :'material_type' => :'materialType',
        :'quantity3_desc' => :'quantity3Desc'
      }
    end
  end
end

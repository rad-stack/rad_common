module Pace
  class EstimatePart < Base
    attr_accessor :id

    attr_accessor :certification_product_classification

    attr_accessor :description

    attr_accessor :weight

    attr_accessor :colors_side1

    attr_accessor :include_mailing

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ink_coverage_back

    attr_accessor :sequence

    attr_accessor :sales_category

    attr_accessor :certification_authority

    attr_accessor :use_price_list_pricing

    attr_accessor :certification_level

    attr_accessor :price_list

    attr_accessor :allowable_overs

    attr_accessor :outside_purchase_markup

    attr_accessor :tax_category

    attr_accessor :manufacturing_location

    attr_accessor :quantity

    attr_accessor :pricing_uom

    attr_accessor :price_level

    attr_accessor :outside_purchase_markup_forced

    attr_accessor :estimate_product

    attr_accessor :outside_purchase_workflow

    attr_accessor :production_type

    attr_accessor :additional_description

    attr_accessor :estimate

    attr_accessor :available_manufacturing_locations

    attr_accessor :user_interface_set

    attr_accessor :total_pages

    attr_accessor :num_sigs

    attr_accessor :colors_total

    attr_accessor :speed_factor

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :metrix_enabled

    attr_accessor :odd_panel_spine_size

    attr_accessor :second_web

    attr_accessor :fold_pattern_key

    attr_accessor :virtual_printer

    attr_accessor :metrix_component_id

    attr_accessor :fold_pattern

    attr_accessor :pattern_category

    attr_accessor :metrix_id

    attr_accessor :press_event_workflow

    attr_accessor :coating

    attr_accessor :varnish

    attr_accessor :odd_panel_width_size

    attr_accessor :num_odd_panels_spine

    attr_accessor :num_odd_panels_width

    attr_accessor :shipping_workflow

    attr_accessor :resolution

    attr_accessor :collate_on_printer

    attr_accessor :spine_size

    attr_accessor :non_image_face

    attr_accessor :reading_direction

    attr_accessor :bleeds_across

    attr_accessor :bleeds_along

    attr_accessor :non_image_foot

    attr_accessor :non_image_foot_display_uom

    attr_accessor :trim_face

    attr_accessor :bleeds_foot

    attr_accessor :trim_size_width

    attr_accessor :trim_foot

    attr_accessor :include_signatures_to_auto_count_collation

    attr_accessor :tab_head

    attr_accessor :non_image_face_display_uom

    attr_accessor :page_delivery

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

    attr_accessor :trim_size_height

    attr_accessor :visual_opening_size_height

    attr_accessor :contour_perimeter

    attr_accessor :tab_foot

    attr_accessor :trim_head

    attr_accessor :margin_right

    attr_accessor :trim_spine

    attr_accessor :trim_size_width_display_uom

    attr_accessor :bleeds_head

    attr_accessor :bleeds_spine

    attr_accessor :prepress_workflow

    attr_accessor :visual_opening_spine

    attr_accessor :tile_product

    attr_accessor :separate_layout

    attr_accessor :binding_side

    attr_accessor :gangable

    attr_accessor :jog_trim

    attr_accessor :jog_trim_display_uom

    attr_accessor :non_image_head

    attr_accessor :contour_perimeter_uom

    attr_accessor :non_image_head_display_uom

    attr_accessor :margin_bottom

    attr_accessor :visual_opening_size_width

    attr_accessor :trim_size_height_display_uom

    attr_accessor :margin_bottom_display_uom

    attr_accessor :num_plies

    attr_accessor :job_product_type

    attr_accessor :component_description

    attr_accessor :requires_imposition

    attr_accessor :margin_right_display_uom

    attr_accessor :visual_opening_head

    attr_accessor :final_size_height

    attr_accessor :final_size_height_display_uom

    attr_accessor :difficulty

    attr_accessor :final_size_width

    attr_accessor :each_of_pricing

    attr_accessor :suppress_zero_priced_items

    attr_accessor :final_size_width_display_uom

    attr_accessor :coating_sides

    attr_accessor :num_pages

    attr_accessor :ink_changed

    attr_accessor :varnish_changed

    attr_accessor :ink_coverage_front_specify

    attr_accessor :ink_coverage_front

    attr_accessor :ink_default

    attr_accessor :varnish_dry

    attr_accessor :press_ink_type

    attr_accessor :coating_changed

    attr_accessor :coating_dry

    attr_accessor :varnish_sides

    attr_accessor :ink_coverage_back_specify

    attr_accessor :product_type

    attr_accessor :item_product_condition

    attr_accessor :is_one_web_only

    attr_accessor :short_page_dimension

    attr_accessor :price_level_forced

    attr_accessor :binding_method_changed

    attr_accessor :chargeable_makeready_percent

    attr_accessor :num_short_panels_width

    attr_accessor :from_composite

    attr_accessor :shipping_workflow_changed

    attr_accessor :calc_step_repeat

    attr_accessor :convert_date

    attr_accessor :item_discount_percent_forced

    attr_accessor :binding_method

    attr_accessor :flat_size_width

    attr_accessor :calc_compose

    attr_accessor :num_short_panels_spine

    attr_accessor :product_type_changed

    attr_accessor :manual_overs_and_waste

    attr_accessor :flat_size_height_display_uom

    attr_accessor :quantities

    attr_accessor :primary_press_changed

    attr_accessor :outside_purchase_workflow_changed

    attr_accessor :total_text_pages

    attr_accessor :register_side2

    attr_accessor :flat_size_width_display_uom

    attr_accessor :register_side1

    attr_accessor :num_color_changes

    attr_accessor :total_cover_pages

    attr_accessor :last_quantity_converted

    attr_accessor :flat_size_height

    attr_accessor :press_event_workflow_changed

    attr_accessor :prepress_workflow_changed

    attr_accessor :item_discount_percent

    attr_accessor :manual_waste

    attr_accessor :metrix_finishing_group_ids


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'certification_product_classification' => :'certificationProductClassification',
        :'description' => :'description',
        :'weight' => :'weight',
        :'colors_side1' => :'colorsSide1',
        :'include_mailing' => :'includeMailing',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ink_coverage_back' => :'inkCoverageBack',
        :'sequence' => :'sequence',
        :'sales_category' => :'salesCategory',
        :'certification_authority' => :'certificationAuthority',
        :'use_price_list_pricing' => :'usePriceListPricing',
        :'certification_level' => :'certificationLevel',
        :'price_list' => :'priceList',
        :'allowable_overs' => :'allowableOvers',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'tax_category' => :'taxCategory',
        :'manufacturing_location' => :'manufacturingLocation',
        :'quantity' => :'quantity',
        :'pricing_uom' => :'pricingUOM',
        :'price_level' => :'priceLevel',
        :'outside_purchase_markup_forced' => :'outsidePurchaseMarkupForced',
        :'estimate_product' => :'estimateProduct',
        :'outside_purchase_workflow' => :'outsidePurchaseWorkflow',
        :'production_type' => :'productionType',
        :'additional_description' => :'additionalDescription',
        :'estimate' => :'estimate',
        :'available_manufacturing_locations' => :'availableManufacturingLocations',
        :'user_interface_set' => :'userInterfaceSet',
        :'total_pages' => :'totalPages',
        :'num_sigs' => :'numSigs',
        :'colors_total' => :'colorsTotal',
        :'speed_factor' => :'speedFactor',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'metrix_enabled' => :'metrixEnabled',
        :'odd_panel_spine_size' => :'oddPanelSpineSize',
        :'second_web' => :'secondWeb',
        :'fold_pattern_key' => :'foldPatternKey',
        :'virtual_printer' => :'virtualPrinter',
        :'metrix_component_id' => :'metrixComponentID',
        :'fold_pattern' => :'foldPattern',
        :'pattern_category' => :'patternCategory',
        :'metrix_id' => :'metrixID',
        :'press_event_workflow' => :'pressEventWorkflow',
        :'coating' => :'coating',
        :'varnish' => :'varnish',
        :'odd_panel_width_size' => :'oddPanelWidthSize',
        :'num_odd_panels_spine' => :'numOddPanelsSpine',
        :'num_odd_panels_width' => :'numOddPanelsWidth',
        :'shipping_workflow' => :'shippingWorkflow',
        :'resolution' => :'resolution',
        :'collate_on_printer' => :'collateOnPrinter',
        :'spine_size' => :'spineSize',
        :'non_image_face' => :'nonImageFace',
        :'reading_direction' => :'readingDirection',
        :'bleeds_across' => :'bleedsAcross',
        :'bleeds_along' => :'bleedsAlong',
        :'non_image_foot' => :'nonImageFoot',
        :'non_image_foot_display_uom' => :'nonImageFootDisplayUOM',
        :'trim_face' => :'trimFace',
        :'bleeds_foot' => :'bleedsFoot',
        :'trim_size_width' => :'trimSizeWidth',
        :'trim_foot' => :'trimFoot',
        :'include_signatures_to_auto_count_collation' => :'includeSignaturesToAutoCountCollation',
        :'tab_head' => :'tabHead',
        :'non_image_face_display_uom' => :'nonImageFaceDisplayUOM',
        :'page_delivery' => :'pageDelivery',
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
        :'trim_size_height' => :'trimSizeHeight',
        :'visual_opening_size_height' => :'visualOpeningSizeHeight',
        :'contour_perimeter' => :'contourPerimeter',
        :'tab_foot' => :'tabFoot',
        :'trim_head' => :'trimHead',
        :'margin_right' => :'marginRight',
        :'trim_spine' => :'trimSpine',
        :'trim_size_width_display_uom' => :'trimSizeWidthDisplayUOM',
        :'bleeds_head' => :'bleedsHead',
        :'bleeds_spine' => :'bleedsSpine',
        :'prepress_workflow' => :'prepressWorkflow',
        :'visual_opening_spine' => :'visualOpeningSpine',
        :'tile_product' => :'tileProduct',
        :'separate_layout' => :'separateLayout',
        :'binding_side' => :'bindingSide',
        :'gangable' => :'gangable',
        :'jog_trim' => :'jogTrim',
        :'jog_trim_display_uom' => :'jogTrimDisplayUOM',
        :'non_image_head' => :'nonImageHead',
        :'contour_perimeter_uom' => :'contourPerimeterUOM',
        :'non_image_head_display_uom' => :'nonImageHeadDisplayUOM',
        :'margin_bottom' => :'marginBottom',
        :'visual_opening_size_width' => :'visualOpeningSizeWidth',
        :'trim_size_height_display_uom' => :'trimSizeHeightDisplayUOM',
        :'margin_bottom_display_uom' => :'marginBottomDisplayUOM',
        :'num_plies' => :'numPlies',
        :'job_product_type' => :'jobProductType',
        :'component_description' => :'componentDescription',
        :'requires_imposition' => :'requiresImposition',
        :'margin_right_display_uom' => :'marginRightDisplayUOM',
        :'visual_opening_head' => :'visualOpeningHead',
        :'final_size_height' => :'finalSizeHeight',
        :'final_size_height_display_uom' => :'finalSizeHeightDisplayUOM',
        :'difficulty' => :'difficulty',
        :'final_size_width' => :'finalSizeWidth',
        :'each_of_pricing' => :'eachOfPricing',
        :'suppress_zero_priced_items' => :'suppressZeroPricedItems',
        :'final_size_width_display_uom' => :'finalSizeWidthDisplayUOM',
        :'coating_sides' => :'coatingSides',
        :'num_pages' => :'numPages',
        :'ink_changed' => :'inkChanged',
        :'varnish_changed' => :'varnishChanged',
        :'ink_coverage_front_specify' => :'inkCoverageFrontSpecify',
        :'ink_coverage_front' => :'inkCoverageFront',
        :'ink_default' => :'inkDefault',
        :'varnish_dry' => :'varnishDry',
        :'press_ink_type' => :'pressInkType',
        :'coating_changed' => :'coatingChanged',
        :'coating_dry' => :'coatingDry',
        :'varnish_sides' => :'varnishSides',
        :'ink_coverage_back_specify' => :'inkCoverageBackSpecify',
        :'product_type' => :'productType',
        :'item_product_condition' => :'itemProductCondition',
        :'is_one_web_only' => :'isOneWebOnly',
        :'short_page_dimension' => :'shortPageDimension',
        :'price_level_forced' => :'priceLevelForced',
        :'binding_method_changed' => :'bindingMethodChanged',
        :'chargeable_makeready_percent' => :'chargeableMakereadyPercent',
        :'num_short_panels_width' => :'numShortPanelsWidth',
        :'from_composite' => :'fromComposite',
        :'shipping_workflow_changed' => :'shippingWorkflowChanged',
        :'calc_step_repeat' => :'calcStepRepeat',
        :'convert_date' => :'convertDate',
        :'item_discount_percent_forced' => :'itemDiscountPercentForced',
        :'binding_method' => :'bindingMethod',
        :'flat_size_width' => :'flatSizeWidth',
        :'calc_compose' => :'calcCompose',
        :'num_short_panels_spine' => :'numShortPanelsSpine',
        :'product_type_changed' => :'productTypeChanged',
        :'manual_overs_and_waste' => :'manualOversAndWaste',
        :'flat_size_height_display_uom' => :'flatSizeHeightDisplayUOM',
        :'quantities' => :'quantities',
        :'primary_press_changed' => :'primaryPressChanged',
        :'outside_purchase_workflow_changed' => :'outsidePurchaseWorkflowChanged',
        :'total_text_pages' => :'totalTextPages',
        :'register_side2' => :'registerSide2',
        :'flat_size_width_display_uom' => :'flatSizeWidthDisplayUOM',
        :'register_side1' => :'registerSide1',
        :'num_color_changes' => :'numColorChanges',
        :'total_cover_pages' => :'totalCoverPages',
        :'last_quantity_converted' => :'lastQuantityConverted',
        :'flat_size_height' => :'flatSizeHeight',
        :'press_event_workflow_changed' => :'pressEventWorkflowChanged',
        :'prepress_workflow_changed' => :'prepressWorkflowChanged',
        :'item_discount_percent' => :'itemDiscountPercent',
        :'manual_waste' => :'manualWaste',
        :'metrix_finishing_group_ids' => :'metrixFinishingGroupIds'
      }
    end
  end
end

module Pace
  class EstimateQuantity < Base
    attr_accessor :id

    attr_accessor :dirty

    attr_accessor :description

    attr_accessor :position

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :overall_sell_markup

    attr_accessor :overall_markup

    attr_accessor :allowable_overs

    attr_accessor :value_added_markup

    attr_accessor :outside_purchase_markup

    attr_accessor :non_value_added_markup

    attr_accessor :paper_markup

    attr_accessor :markup_percent

    attr_accessor :price

    attr_accessor :estimate_part

    attr_accessor :price_per_addl_uom_forced

    attr_accessor :price_per_addl100

    attr_accessor :quoted_price_per_addl100_forced

    attr_accessor :max_payment_term_discount

    attr_accessor :price_per_addl_uom

    attr_accessor :pricing_uom

    attr_accessor :effective_commission_rate_forced

    attr_accessor :non_value_added_price

    attr_accessor :quoted_price

    attr_accessor :tax_base

    attr_accessor :quoted_price_per_addl100

    attr_accessor :quoted_price_per_addl_m

    attr_accessor :outside_purchase_markup_forced

    attr_accessor :markup

    attr_accessor :grand_total

    attr_accessor :price_per_addl_m

    attr_accessor :pricing_units_forced

    attr_accessor :quoted_price_forced

    attr_accessor :value_added_price

    attr_accessor :tax_amount

    attr_accessor :quantity_ordered

    attr_accessor :value_added_markup_forced

    attr_accessor :outside_purchase_setup_markup

    attr_accessor :overall_sell_markup_forced

    attr_accessor :quoted_price_per_addl_m_forced

    attr_accessor :price_per_uom

    attr_accessor :pricing_units

    attr_accessor :non_value_added_markup_forced

    attr_accessor :outside_purchase_setup_markup_forced

    attr_accessor :cost

    attr_accessor :overall_markup_forced

    attr_accessor :paper_markup_forced

    attr_accessor :effective_commission_rate

    attr_accessor :price_per_uom_forced

    attr_accessor :estimate

    attr_accessor :target_sell

    attr_accessor :metrix_id

    attr_accessor :gripper_color_bar

    attr_accessor :num_sigs_odd_press_form

    attr_accessor :sheets_off_press

    attr_accessor :next_sequence

    attr_accessor :comm_rate

    attr_accessor :cost_per_m

    attr_accessor :num_sigs_per_press_form

    attr_accessor :mxml

    attr_accessor :overall_ink_coverage_side2

    attr_accessor :overall_ink_coverage_side1

    attr_accessor :manual_waste

    attr_accessor :weight_per_piece

    attr_accessor :contribution_analysis_discount

    attr_accessor :dirty_reason

    attr_accessor :price_per_each_forced

    attr_accessor :max_payment_term_discount_percent

    attr_accessor :mxml_from_metrix

    attr_accessor :mxml_to_client

    attr_accessor :price_per_each

    attr_accessor :contribution_analysis_tax_amount

    attr_accessor :position_state

    attr_accessor :non_value_added_percent

    attr_accessor :value_added

    attr_accessor :tax_effective_percent

    attr_accessor :new_quantity

    attr_accessor :alternate_print_method_applied

    attr_accessor :price_per_addl100_forced

    attr_accessor :margin_percent

    attr_accessor :value_added_per_press_hour

    attr_accessor :additional_weight_per_piece

    attr_accessor :chart_description

    attr_accessor :non_value_added

    attr_accessor :value_added_percent

    attr_accessor :price_dirty

    attr_accessor :combo_percent

    attr_accessor :combo_percent_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'dirty' => :'dirty',
        :'description' => :'description',
        :'position' => :'position',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'overall_sell_markup' => :'overallSellMarkup',
        :'overall_markup' => :'overallMarkup',
        :'allowable_overs' => :'allowableOvers',
        :'value_added_markup' => :'valueAddedMarkup',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'non_value_added_markup' => :'nonValueAddedMarkup',
        :'paper_markup' => :'paperMarkup',
        :'markup_percent' => :'markupPercent',
        :'price' => :'price',
        :'estimate_part' => :'estimatePart',
        :'price_per_addl_uom_forced' => :'pricePerAddlUOMForced',
        :'price_per_addl100' => :'pricePerAddl100',
        :'quoted_price_per_addl100_forced' => :'quotedPricePerAddl100Forced',
        :'max_payment_term_discount' => :'maxPaymentTermDiscount',
        :'price_per_addl_uom' => :'pricePerAddlUOM',
        :'pricing_uom' => :'pricingUOM',
        :'effective_commission_rate_forced' => :'effectiveCommissionRateForced',
        :'non_value_added_price' => :'nonValueAddedPrice',
        :'quoted_price' => :'quotedPrice',
        :'tax_base' => :'taxBase',
        :'quoted_price_per_addl100' => :'quotedPricePerAddl100',
        :'quoted_price_per_addl_m' => :'quotedPricePerAddlM',
        :'outside_purchase_markup_forced' => :'outsidePurchaseMarkupForced',
        :'markup' => :'markup',
        :'grand_total' => :'grandTotal',
        :'price_per_addl_m' => :'pricePerAddlM',
        :'pricing_units_forced' => :'pricingUnitsForced',
        :'quoted_price_forced' => :'quotedPriceForced',
        :'value_added_price' => :'valueAddedPrice',
        :'tax_amount' => :'taxAmount',
        :'quantity_ordered' => :'quantityOrdered',
        :'value_added_markup_forced' => :'valueAddedMarkupForced',
        :'outside_purchase_setup_markup' => :'outsidePurchaseSetupMarkup',
        :'overall_sell_markup_forced' => :'overallSellMarkupForced',
        :'quoted_price_per_addl_m_forced' => :'quotedPricePerAddlMForced',
        :'price_per_uom' => :'pricePerUOM',
        :'pricing_units' => :'pricingUnits',
        :'non_value_added_markup_forced' => :'nonValueAddedMarkupForced',
        :'outside_purchase_setup_markup_forced' => :'outsidePurchaseSetupMarkupForced',
        :'cost' => :'cost',
        :'overall_markup_forced' => :'overallMarkupForced',
        :'paper_markup_forced' => :'paperMarkupForced',
        :'effective_commission_rate' => :'effectiveCommissionRate',
        :'price_per_uom_forced' => :'pricePerUOMForced',
        :'estimate' => :'estimate',
        :'target_sell' => :'targetSell',
        :'metrix_id' => :'metrixID',
        :'gripper_color_bar' => :'gripperColorBar',
        :'num_sigs_odd_press_form' => :'numSigsOddPressForm',
        :'sheets_off_press' => :'sheetsOffPress',
        :'next_sequence' => :'nextSequence',
        :'comm_rate' => :'commRate',
        :'cost_per_m' => :'costPerM',
        :'num_sigs_per_press_form' => :'numSigsPerPressForm',
        :'mxml' => :'mxml',
        :'overall_ink_coverage_side2' => :'overallInkCoverageSide2',
        :'overall_ink_coverage_side1' => :'overallInkCoverageSide1',
        :'manual_waste' => :'manualWaste',
        :'weight_per_piece' => :'weightPerPiece',
        :'contribution_analysis_discount' => :'contributionAnalysisDiscount',
        :'dirty_reason' => :'dirtyReason',
        :'price_per_each_forced' => :'pricePerEachForced',
        :'max_payment_term_discount_percent' => :'maxPaymentTermDiscountPercent',
        :'mxml_from_metrix' => :'mxmlFromMetrix',
        :'mxml_to_client' => :'mxmlToClient',
        :'price_per_each' => :'pricePerEach',
        :'contribution_analysis_tax_amount' => :'contributionAnalysisTaxAmount',
        :'position_state' => :'positionState',
        :'non_value_added_percent' => :'nonValueAddedPercent',
        :'value_added' => :'valueAdded',
        :'tax_effective_percent' => :'taxEffectivePercent',
        :'new_quantity' => :'newQuantity',
        :'alternate_print_method_applied' => :'alternatePrintMethodApplied',
        :'price_per_addl100_forced' => :'pricePerAddl100Forced',
        :'margin_percent' => :'marginPercent',
        :'value_added_per_press_hour' => :'valueAddedPerPressHour',
        :'additional_weight_per_piece' => :'additionalWeightPerPiece',
        :'chart_description' => :'chartDescription',
        :'non_value_added' => :'nonValueAdded',
        :'value_added_percent' => :'valueAddedPercent',
        :'price_dirty' => :'priceDirty',
        :'combo_percent' => :'comboPercent',
        :'combo_percent_forced' => :'comboPercentForced'
      }
    end
  end
end

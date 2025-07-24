module Pace
  class EstimateSetup < Base
    attr_accessor :id

    attr_accessor :max_film_size

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_quote_letter_type

    attr_accessor :estimate

    attr_accessor :use_manufacturing_location_prefix

    attr_accessor :default_convert_to_job_status

    attr_accessor :have_sheeter

    attr_accessor :display_binder_cycles

    attr_accessor :contribution_total_label

    attr_accessor :metrix_client_timeout

    attr_accessor :include_cost_markup

    attr_accessor :estimate_convert_price_display_method

    attr_accessor :display_no_result_grid

    attr_accessor :contribution_sub_total_label

    attr_accessor :restrict_press_attribute_forcing

    attr_accessor :paper_activity_code

    attr_accessor :include_discount_in_contribution_analysis

    attr_accessor :min_margin_percent

    attr_accessor :base_outside_purchase_markup

    attr_accessor :bias_ganging

    attr_accessor :base_overall_markup

    attr_accessor :allow_manual_overs_and_waste_entry

    attr_accessor :auto_calc_penalty_per_cut

    attr_accessor :base_non_value_add_markup

    attr_accessor :default_material_type

    attr_accessor :estimate_optimization_method

    attr_accessor :base_overall_sell_markup

    attr_accessor :embedded_metrix_timeout

    attr_accessor :metrix_automation_server_permutations_limit

    attr_accessor :restrict_objects_by_locations

    attr_accessor :default_status_converted_estimate

    attr_accessor :add_binder_to_first_part_only

    attr_accessor :outside_purch_setup_activity_code

    attr_accessor :reset_press_layout

    attr_accessor :group_parts_by_product

    attr_accessor :markup_type

    attr_accessor :paper_make_ready_activity_code

    attr_accessor :add_crm_activity_on_status_change

    attr_accessor :textbook_round_mweight

    attr_accessor :display_folder_cycles

    attr_accessor :auto_add_postpress_cutting

    attr_accessor :default_price_list_pricing_rate_level

    attr_accessor :enable_simple_product_add

    attr_accessor :outside_purch_activity_code

    attr_accessor :quantity_entry_factor

    attr_accessor :contribution_cat_breakdown_total_label

    attr_accessor :min_value_added_percent

    attr_accessor :convert_job_to_estimate_method

    attr_accessor :require_quantity_selection

    attr_accessor :default_ink_coverage

    attr_accessor :base_paper_markup

    attr_accessor :refresh_detail

    attr_accessor :commission_activity_code

    attr_accessor :auto_calc_penalty_num_up

    attr_accessor :max_film_size_display_uom

    attr_accessor :min_value_added_amount

    attr_accessor :do_not_convert_zero_priced_estimate_items

    attr_accessor :embedded_metrix_permutations_limit

    attr_accessor :use_combined_click_charges

    attr_accessor :use_estimate_shipments

    attr_accessor :include_additional_quote_item_markup

    attr_accessor :default_follow_up_days

    attr_accessor :default_gripper_color_bar

    attr_accessor :even_carton_default

    attr_accessor :recalculate_estimate_item_prices

    attr_accessor :use_auto_complete

    attr_accessor :use_interactive_pricing_summary

    attr_accessor :include_payment_term_discount

    attr_accessor :paper_rounding_mode

    attr_accessor :use_inverse_commission_calculation

    attr_accessor :duplicate_all_quantities_on_add_part_version

    attr_accessor :convert_csr_to_job

    attr_accessor :include_sales_tax_in_contribution_analysis

    attr_accessor :estimate_prefix

    attr_accessor :contribution_cat_breakdown_sell_price_label

    attr_accessor :base_comm_rate

    attr_accessor :no_result_activity

    attr_accessor :allow_convert_and_update_from_job

    attr_accessor :price_display_level

    attr_accessor :base_price_level

    attr_accessor :add_crm_opportunity_on_status_change

    attr_accessor :base_value_add_markup

    attr_accessor :min_margin_amount

    attr_accessor :metrix_timeout_warning

    attr_accessor :price_rounding_method


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'max_film_size' => :'maxFilmSize',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_quote_letter_type' => :'defaultQuoteLetterType',
        :'estimate' => :'estimate',
        :'use_manufacturing_location_prefix' => :'useManufacturingLocationPrefix',
        :'default_convert_to_job_status' => :'defaultConvertToJobStatus',
        :'have_sheeter' => :'haveSheeter',
        :'display_binder_cycles' => :'displayBinderCycles',
        :'contribution_total_label' => :'contributionTotalLabel',
        :'metrix_client_timeout' => :'metrixClientTimeout',
        :'include_cost_markup' => :'includeCostMarkup',
        :'estimate_convert_price_display_method' => :'estimateConvertPriceDisplayMethod',
        :'display_no_result_grid' => :'displayNoResultGrid',
        :'contribution_sub_total_label' => :'contributionSubTotalLabel',
        :'restrict_press_attribute_forcing' => :'restrictPressAttributeForcing',
        :'paper_activity_code' => :'paperActivityCode',
        :'include_discount_in_contribution_analysis' => :'includeDiscountInContributionAnalysis',
        :'min_margin_percent' => :'minMarginPercent',
        :'base_outside_purchase_markup' => :'baseOutsidePurchaseMarkup',
        :'bias_ganging' => :'biasGanging',
        :'base_overall_markup' => :'baseOverallMarkup',
        :'allow_manual_overs_and_waste_entry' => :'allowManualOversAndWasteEntry',
        :'auto_calc_penalty_per_cut' => :'autoCalcPenaltyPerCut',
        :'base_non_value_add_markup' => :'baseNonValueAddMarkup',
        :'default_material_type' => :'defaultMaterialType',
        :'estimate_optimization_method' => :'estimateOptimizationMethod',
        :'base_overall_sell_markup' => :'baseOverallSellMarkup',
        :'embedded_metrix_timeout' => :'embeddedMetrixTimeout',
        :'metrix_automation_server_permutations_limit' => :'metrixAutomationServerPermutationsLimit',
        :'restrict_objects_by_locations' => :'restrictObjectsByLocations',
        :'default_status_converted_estimate' => :'defaultStatusConvertedEstimate',
        :'add_binder_to_first_part_only' => :'addBinderToFirstPartOnly',
        :'outside_purch_setup_activity_code' => :'outsidePurchSetupActivityCode',
        :'reset_press_layout' => :'resetPressLayout',
        :'group_parts_by_product' => :'groupPartsByProduct',
        :'markup_type' => :'markupType',
        :'paper_make_ready_activity_code' => :'paperMakeReadyActivityCode',
        :'add_crm_activity_on_status_change' => :'addCRMActivityOnStatusChange',
        :'textbook_round_mweight' => :'textbookRoundMweight',
        :'display_folder_cycles' => :'displayFolderCycles',
        :'auto_add_postpress_cutting' => :'autoAddPostpressCutting',
        :'default_price_list_pricing_rate_level' => :'defaultPriceListPricingRateLevel',
        :'enable_simple_product_add' => :'enableSimpleProductAdd',
        :'outside_purch_activity_code' => :'outsidePurchActivityCode',
        :'quantity_entry_factor' => :'quantityEntryFactor',
        :'contribution_cat_breakdown_total_label' => :'contributionCatBreakdownTotalLabel',
        :'min_value_added_percent' => :'minValueAddedPercent',
        :'convert_job_to_estimate_method' => :'convertJobToEstimateMethod',
        :'require_quantity_selection' => :'requireQuantitySelection',
        :'default_ink_coverage' => :'defaultInkCoverage',
        :'base_paper_markup' => :'basePaperMarkup',
        :'refresh_detail' => :'refreshDetail',
        :'commission_activity_code' => :'commissionActivityCode',
        :'auto_calc_penalty_num_up' => :'autoCalcPenaltyNumUP',
        :'max_film_size_display_uom' => :'maxFilmSizeDisplayUOM',
        :'min_value_added_amount' => :'minValueAddedAmount',
        :'do_not_convert_zero_priced_estimate_items' => :'doNotConvertZeroPricedEstimateItems',
        :'embedded_metrix_permutations_limit' => :'embeddedMetrixPermutationsLimit',
        :'use_combined_click_charges' => :'useCombinedClickCharges',
        :'use_estimate_shipments' => :'useEstimateShipments',
        :'include_additional_quote_item_markup' => :'includeAdditionalQuoteItemMarkup',
        :'default_follow_up_days' => :'defaultFollowUpDays',
        :'default_gripper_color_bar' => :'defaultGripperColorBar',
        :'even_carton_default' => :'evenCartonDefault',
        :'recalculate_estimate_item_prices' => :'recalculateEstimateItemPrices',
        :'use_auto_complete' => :'useAutoComplete',
        :'use_interactive_pricing_summary' => :'useInteractivePricingSummary',
        :'include_payment_term_discount' => :'includePaymentTermDiscount',
        :'paper_rounding_mode' => :'paperRoundingMode',
        :'use_inverse_commission_calculation' => :'useInverseCommissionCalculation',
        :'duplicate_all_quantities_on_add_part_version' => :'duplicateAllQuantitiesOnAddPartVersion',
        :'convert_csr_to_job' => :'convertCsrToJob',
        :'include_sales_tax_in_contribution_analysis' => :'includeSalesTaxInContributionAnalysis',
        :'estimate_prefix' => :'estimatePrefix',
        :'contribution_cat_breakdown_sell_price_label' => :'contributionCatBreakdownSellPriceLabel',
        :'base_comm_rate' => :'baseCommRate',
        :'no_result_activity' => :'noResultActivity',
        :'allow_convert_and_update_from_job' => :'allowConvertAndUpdateFromJob',
        :'price_display_level' => :'priceDisplayLevel',
        :'base_price_level' => :'basePriceLevel',
        :'add_crm_opportunity_on_status_change' => :'addCRMOpportunityOnStatusChange',
        :'base_value_add_markup' => :'baseValueAddMarkup',
        :'min_margin_amount' => :'minMarginAmount',
        :'metrix_timeout_warning' => :'metrixTimeoutWarning',
        :'price_rounding_method' => :'priceRoundingMethod'
      }
    end
  end
end

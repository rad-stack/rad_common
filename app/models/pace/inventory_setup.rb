module Pace
  class InventorySetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_register_number_sequence

    attr_accessor :interface_gl

    attr_accessor :allow_process_all

    attr_accessor :interface_jc

    attr_accessor :serial_id

    attr_accessor :default_location

    attr_accessor :verify_negative_quantity

    attr_accessor :location_bin_key

    attr_accessor :lot_id

    attr_accessor :background_calculate_qty_allocated

    attr_accessor :default_override_po_price

    attr_accessor :auto_assign_rolls_maximum_number_of_rolls

    attr_accessor :revision_id

    attr_accessor :serial_ids

    attr_accessor :inventory_locations

    attr_accessor :auto_assign_rolls_maximum_number_of_inventory_switches

    attr_accessor :class_b_threshold

    attr_accessor :lifo_valuation

    attr_accessor :class_a_threshold

    attr_accessor :auto_assign_rolls_maximum_number_of_job_plans

    attr_accessor :integrate_gl

    attr_accessor :last_purged

    attr_accessor :pull_material_from_cost_center_location

    attr_accessor :inventory_bins

    attr_accessor :price_by_product_group

    attr_accessor :qty_based_pricing

    attr_accessor :auto_assign_rolls_print_run_buffer

    attr_accessor :inventory_item_id

    attr_accessor :use_location_stock_level

    attr_accessor :auto_assign_rolls_cost_center_type

    attr_accessor :validate_planned_quantity

    attr_accessor :auto_assign_rolls_maximum_number_of_days

    attr_accessor :costing_method

    attr_accessor :keep_mvmnt_flag

    attr_accessor :do_not_calculate_qty_allocated

    attr_accessor :require_signout_to_post_dc_pulls

    attr_accessor :keep_days

    attr_accessor :lots_and_revision_ids

    attr_accessor :zero_cost_customer_owned_inventory_shipments

    attr_accessor :validate_material

    attr_accessor :print_register

    attr_accessor :default_bin

    attr_accessor :set_basis_weight_from_paper_weight

    attr_accessor :register_report


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_register_number_sequence' => :'glRegisterNumberSequence',
        :'interface_gl' => :'interfaceGL',
        :'allow_process_all' => :'allowProcessAll',
        :'interface_jc' => :'interfaceJC',
        :'serial_id' => :'serialID',
        :'default_location' => :'defaultLocation',
        :'verify_negative_quantity' => :'verifyNegativeQuantity',
        :'location_bin_key' => :'locationBinKey',
        :'lot_id' => :'lotID',
        :'background_calculate_qty_allocated' => :'backgroundCalculateQtyAllocated',
        :'default_override_po_price' => :'defaultOverridePOPrice',
        :'auto_assign_rolls_maximum_number_of_rolls' => :'autoAssignRollsMaximumNumberOfRolls',
        :'revision_id' => :'revisionID',
        :'serial_ids' => :'serialIDs',
        :'inventory_locations' => :'inventoryLocations',
        :'auto_assign_rolls_maximum_number_of_inventory_switches' => :'autoAssignRollsMaximumNumberOfInventorySwitches',
        :'class_b_threshold' => :'classBThreshold',
        :'lifo_valuation' => :'lifoValuation',
        :'class_a_threshold' => :'classAThreshold',
        :'auto_assign_rolls_maximum_number_of_job_plans' => :'autoAssignRollsMaximumNumberOfJobPlans',
        :'integrate_gl' => :'integrateGL',
        :'last_purged' => :'lastPurged',
        :'pull_material_from_cost_center_location' => :'pullMaterialFromCostCenterLocation',
        :'inventory_bins' => :'inventoryBins',
        :'price_by_product_group' => :'priceByProductGroup',
        :'qty_based_pricing' => :'qtyBasedPricing',
        :'auto_assign_rolls_print_run_buffer' => :'autoAssignRollsPrintRunBuffer',
        :'inventory_item_id' => :'inventoryItemID',
        :'use_location_stock_level' => :'useLocationStockLevel',
        :'auto_assign_rolls_cost_center_type' => :'autoAssignRollsCostCenterType',
        :'validate_planned_quantity' => :'validatePlannedQuantity',
        :'auto_assign_rolls_maximum_number_of_days' => :'autoAssignRollsMaximumNumberOfDays',
        :'costing_method' => :'costingMethod',
        :'keep_mvmnt_flag' => :'keepMvmntFlag',
        :'do_not_calculate_qty_allocated' => :'doNotCalculateQtyAllocated',
        :'require_signout_to_post_dc_pulls' => :'requireSignoutToPostDCPulls',
        :'keep_days' => :'keepDays',
        :'lots_and_revision_ids' => :'lotsAndRevisionIDs',
        :'zero_cost_customer_owned_inventory_shipments' => :'zeroCostCustomerOwnedInventoryShipments',
        :'validate_material' => :'validateMaterial',
        :'print_register' => :'printRegister',
        :'default_bin' => :'defaultBin',
        :'set_basis_weight_from_paper_weight' => :'setBasisWeightFromPaperWeight',
        :'register_report' => :'registerReport'
      }
    end
  end
end

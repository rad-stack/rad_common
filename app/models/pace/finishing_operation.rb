module Pace
  class FinishingOperation < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :rounding_mode

    attr_accessor :description

    attr_accessor :number_helpers

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :setup_time

    attr_accessor :unit_label

    attr_accessor :speed_adjustment

    attr_accessor :quantity

    attr_accessor :material_cost_per_m

    attr_accessor :binder

    attr_accessor :note

    attr_accessor :machine_category

    attr_accessor :customer_viewable

    attr_accessor :estimate_expression

    attr_accessor :cutter

    attr_accessor :generic_finishing_machine

    attr_accessor :cover_fold_width

    attr_accessor :folder

    attr_accessor :numbering_start

    attr_accessor :make_ready_spoilage

    attr_accessor :stack_amount

    attr_accessor :three_knife

    attr_accessor :num_up

    attr_accessor :router

    attr_accessor :rotate_stack

    attr_accessor :cutter_alignment_mark_group

    attr_accessor :image_shift

    attr_accessor :cover_fold_width_display_uom

    attr_accessor :padding

    attr_accessor :image_shift_display_uom

    attr_accessor :jdf_finishing_type

    attr_accessor :setup_material_cost

    attr_accessor :metrix_enabled

    attr_accessor :sell_price_per_m

    attr_accessor :use_upto_size

    attr_accessor :make_ready_activity_code

    attr_accessor :remove_if_not_required

    attr_accessor :sell_setup_price

    attr_accessor :non_combo_quantity

    attr_accessor :operation_type

    attr_accessor :quantity_calc_method

    attr_accessor :minimum_run_cost

    attr_accessor :add_material_cost

    attr_accessor :quantity_multiplier

    attr_accessor :manufacturing_locations

    attr_accessor :use_machine_activity_codes

    attr_accessor :include_setup_material_cost_in_materials_activity_code

    attr_accessor :machine_type

    attr_accessor :setup_per_signature

    attr_accessor :finishing_group

    attr_accessor :helper_activity_code

    attr_accessor :materials_included_in_additional_piece_weight

    attr_accessor :max_caliper

    attr_accessor :estimate_request_item_template

    attr_accessor :alt_description

    attr_accessor :metrix_finishing_group

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'rounding_mode' => :'roundingMode',
        :'description' => :'description',
        :'number_helpers' => :'numberHelpers',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'setup_time' => :'setupTime',
        :'unit_label' => :'unitLabel',
        :'speed_adjustment' => :'speedAdjustment',
        :'quantity' => :'quantity',
        :'material_cost_per_m' => :'materialCostPerM',
        :'binder' => :'binder',
        :'note' => :'note',
        :'machine_category' => :'machineCategory',
        :'customer_viewable' => :'customerViewable',
        :'estimate_expression' => :'estimateExpression',
        :'cutter' => :'cutter',
        :'generic_finishing_machine' => :'genericFinishingMachine',
        :'cover_fold_width' => :'coverFoldWidth',
        :'folder' => :'folder',
        :'numbering_start' => :'numberingStart',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'stack_amount' => :'stackAmount',
        :'three_knife' => :'threeKnife',
        :'num_up' => :'numUp',
        :'router' => :'router',
        :'rotate_stack' => :'rotateStack',
        :'cutter_alignment_mark_group' => :'cutterAlignmentMarkGroup',
        :'image_shift' => :'imageShift',
        :'cover_fold_width_display_uom' => :'coverFoldWidthDisplayUOM',
        :'padding' => :'padding',
        :'image_shift_display_uom' => :'imageShiftDisplayUOM',
        :'jdf_finishing_type' => :'jdfFinishingType',
        :'setup_material_cost' => :'setupMaterialCost',
        :'metrix_enabled' => :'metrixEnabled',
        :'sell_price_per_m' => :'sellPricePerM',
        :'use_upto_size' => :'useUptoSize',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'remove_if_not_required' => :'removeIfNotRequired',
        :'sell_setup_price' => :'sellSetupPrice',
        :'non_combo_quantity' => :'nonComboQuantity',
        :'operation_type' => :'operationType',
        :'quantity_calc_method' => :'quantityCalcMethod',
        :'minimum_run_cost' => :'minimumRunCost',
        :'add_material_cost' => :'addMaterialCost',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'use_machine_activity_codes' => :'useMachineActivityCodes',
        :'include_setup_material_cost_in_materials_activity_code' => :'includeSetupMaterialCostInMaterialsActivityCode',
        :'machine_type' => :'machineType',
        :'setup_per_signature' => :'setupPerSignature',
        :'finishing_group' => :'finishingGroup',
        :'helper_activity_code' => :'helperActivityCode',
        :'materials_included_in_additional_piece_weight' => :'materialsIncludedInAdditionalPieceWeight',
        :'max_caliper' => :'maxCaliper',
        :'estimate_request_item_template' => :'estimateRequestItemTemplate',
        :'alt_description' => :'altDescription',
        :'metrix_finishing_group' => :'metrixFinishingGroup',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode'
      }
    end
  end
end

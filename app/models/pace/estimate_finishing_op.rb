module Pace
  class EstimateFinishingOp < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :units

    attr_accessor :hours

    attr_accessor :weight

    attr_accessor :number_helpers

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :fiery_property_value

    attr_accessor :fiery_property_value_description

    attr_accessor :estimate_press

    attr_accessor :created_from_split

    attr_accessor :auto_change

    attr_accessor :fiery_property_description

    attr_accessor :finishing_operation

    attr_accessor :fiery_property

    attr_accessor :quantity

    attr_accessor :binder

    attr_accessor :note

    attr_accessor :customer_viewable

    attr_accessor :quantity_forced

    attr_accessor :correlation_id

    attr_accessor :unit_label_forced

    attr_accessor :hours_forced

    attr_accessor :estimate_quantity

    attr_accessor :add_hours

    attr_accessor :generic_finishing_machine_forced

    attr_accessor :cutter

    attr_accessor :generic_finishing_machine

    attr_accessor :folded_sheet_size_height_display_uom

    attr_accessor :binder_forced

    attr_accessor :finishing_operation_material_quantity_forced

    attr_accessor :folder_forced

    attr_accessor :cover_fold_width

    attr_accessor :folder

    attr_accessor :number_scores

    attr_accessor :finishing_operation_material_quantity

    attr_accessor :fktag_finishingoperationmaterial

    attr_accessor :num_stagger_forced

    attr_accessor :qty_per_unit

    attr_accessor :make_ready_hours

    attr_accessor :num_across

    attr_accessor :numbering_start

    attr_accessor :make_ready_spoilage

    attr_accessor :stack_amount

    attr_accessor :number_slits_forced

    attr_accessor :num_across_forced

    attr_accessor :make_ready_materials

    attr_accessor :units_forced

    attr_accessor :barcode_value

    attr_accessor :three_knife

    attr_accessor :router_forced

    attr_accessor :folder_gap_forced

    attr_accessor :folded_sheet_size_height

    attr_accessor :num_along_forced

    attr_accessor :num_passes_forced

    attr_accessor :num_up

    attr_accessor :number_perfs_forced

    attr_accessor :run_speed

    attr_accessor :used

    attr_accessor :number_helpers_forced

    attr_accessor :router

    attr_accessor :num_stagger

    attr_accessor :finishing_operation_material_forced

    attr_accessor :rotate_stack

    attr_accessor :cutter_alignment_mark_group

    attr_accessor :qty_per_unit_forced

    attr_accessor :finishing_operation_material

    attr_accessor :number_slits

    attr_accessor :padding_forced

    attr_accessor :number_glues

    attr_accessor :image_shift

    attr_accessor :num_along

    attr_accessor :folded_sheet_size_width_display_uom

    attr_accessor :folder_gap_display_uom

    attr_accessor :run_speed_forced

    attr_accessor :review_prompt

    attr_accessor :num_up_forced

    attr_accessor :number_perfs

    attr_accessor :run_materials_forced

    attr_accessor :material_vendor

    attr_accessor :cover_fold_width_display_uom

    attr_accessor :num_passes

    attr_accessor :number_glues_forced

    attr_accessor :operation_level

    attr_accessor :three_knife_forced

    attr_accessor :run_materials

    attr_accessor :run_spoilage

    attr_accessor :following_operation_spoilage

    attr_accessor :run_spoilage_percent

    attr_accessor :add_spoilage_sheets_forced

    attr_accessor :add_spoilage_sheets

    attr_accessor :padding

    attr_accessor :add_hours_forced

    attr_accessor :make_ready_hours_forced

    attr_accessor :in_line

    attr_accessor :include_in_additional_piece_weight

    attr_accessor :number_scores_forced

    attr_accessor :forced_folded_sheet_size

    attr_accessor :folded_sheet_size_width

    attr_accessor :quantity_in

    attr_accessor :image_shift_display_uom

    attr_accessor :folder_gap

    attr_accessor :make_ready_materials_forced

    attr_accessor :cutter_forced

    attr_accessor :fktag_finishingoperation


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'units' => :'units',
        :'hours' => :'hours',
        :'weight' => :'weight',
        :'number_helpers' => :'numberHelpers',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'fiery_property_value' => :'fieryPropertyValue',
        :'fiery_property_value_description' => :'fieryPropertyValueDescription',
        :'estimate_press' => :'estimatePress',
        :'created_from_split' => :'createdFromSplit',
        :'auto_change' => :'autoChange',
        :'fiery_property_description' => :'fieryPropertyDescription',
        :'finishing_operation' => :'finishingOperation',
        :'fiery_property' => :'fieryProperty',
        :'quantity' => :'quantity',
        :'binder' => :'binder',
        :'note' => :'note',
        :'customer_viewable' => :'customerViewable',
        :'quantity_forced' => :'quantityForced',
        :'correlation_id' => :'correlationId',
        :'unit_label_forced' => :'unitLabelForced',
        :'hours_forced' => :'hoursForced',
        :'estimate_quantity' => :'estimateQuantity',
        :'add_hours' => :'addHours',
        :'generic_finishing_machine_forced' => :'genericFinishingMachineForced',
        :'cutter' => :'cutter',
        :'generic_finishing_machine' => :'genericFinishingMachine',
        :'folded_sheet_size_height_display_uom' => :'foldedSheetSizeHeightDisplayUOM',
        :'binder_forced' => :'binderForced',
        :'finishing_operation_material_quantity_forced' => :'finishingOperationMaterialQuantityForced',
        :'folder_forced' => :'folderForced',
        :'cover_fold_width' => :'coverFoldWidth',
        :'folder' => :'folder',
        :'number_scores' => :'numberScores',
        :'finishing_operation_material_quantity' => :'finishingOperationMaterialQuantity',
        :'fktag_finishingoperationmaterial' => :'fktag_finishingoperationmaterial',
        :'num_stagger_forced' => :'numStaggerForced',
        :'qty_per_unit' => :'qtyPerUnit',
        :'make_ready_hours' => :'makeReadyHours',
        :'num_across' => :'numAcross',
        :'numbering_start' => :'numberingStart',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'stack_amount' => :'stackAmount',
        :'number_slits_forced' => :'numberSlitsForced',
        :'num_across_forced' => :'numAcrossForced',
        :'make_ready_materials' => :'makeReadyMaterials',
        :'units_forced' => :'unitsForced',
        :'barcode_value' => :'barcodeValue',
        :'three_knife' => :'threeKnife',
        :'router_forced' => :'routerForced',
        :'folder_gap_forced' => :'folderGapForced',
        :'folded_sheet_size_height' => :'foldedSheetSizeHeight',
        :'num_along_forced' => :'numAlongForced',
        :'num_passes_forced' => :'numPassesForced',
        :'num_up' => :'numUp',
        :'number_perfs_forced' => :'numberPerfsForced',
        :'run_speed' => :'runSpeed',
        :'used' => :'used',
        :'number_helpers_forced' => :'numberHelpersForced',
        :'router' => :'router',
        :'num_stagger' => :'numStagger',
        :'finishing_operation_material_forced' => :'finishingOperationMaterialForced',
        :'rotate_stack' => :'rotateStack',
        :'cutter_alignment_mark_group' => :'cutterAlignmentMarkGroup',
        :'qty_per_unit_forced' => :'qtyPerUnitForced',
        :'finishing_operation_material' => :'finishingOperationMaterial',
        :'number_slits' => :'numberSlits',
        :'padding_forced' => :'paddingForced',
        :'number_glues' => :'numberGlues',
        :'image_shift' => :'imageShift',
        :'num_along' => :'numAlong',
        :'folded_sheet_size_width_display_uom' => :'foldedSheetSizeWidthDisplayUOM',
        :'folder_gap_display_uom' => :'folderGapDisplayUOM',
        :'run_speed_forced' => :'runSpeedForced',
        :'review_prompt' => :'reviewPrompt',
        :'num_up_forced' => :'numUpForced',
        :'number_perfs' => :'numberPerfs',
        :'run_materials_forced' => :'runMaterialsForced',
        :'material_vendor' => :'materialVendor',
        :'cover_fold_width_display_uom' => :'coverFoldWidthDisplayUOM',
        :'num_passes' => :'numPasses',
        :'number_glues_forced' => :'numberGluesForced',
        :'operation_level' => :'operationLevel',
        :'three_knife_forced' => :'threeKnifeForced',
        :'run_materials' => :'runMaterials',
        :'run_spoilage' => :'runSpoilage',
        :'following_operation_spoilage' => :'followingOperationSpoilage',
        :'run_spoilage_percent' => :'runSpoilagePercent',
        :'add_spoilage_sheets_forced' => :'addSpoilageSheetsForced',
        :'add_spoilage_sheets' => :'addSpoilageSheets',
        :'padding' => :'padding',
        :'add_hours_forced' => :'addHoursForced',
        :'make_ready_hours_forced' => :'makeReadyHoursForced',
        :'in_line' => :'inLine',
        :'include_in_additional_piece_weight' => :'includeInAdditionalPieceWeight',
        :'number_scores_forced' => :'numberScoresForced',
        :'forced_folded_sheet_size' => :'forcedFoldedSheetSize',
        :'folded_sheet_size_width' => :'foldedSheetSizeWidth',
        :'quantity_in' => :'quantityIn',
        :'image_shift_display_uom' => :'imageShiftDisplayUOM',
        :'folder_gap' => :'folderGap',
        :'make_ready_materials_forced' => :'makeReadyMaterialsForced',
        :'cutter_forced' => :'cutterForced',
        :'fktag_finishingoperation' => :'fktag_finishingoperation'
      }
    end
  end
end

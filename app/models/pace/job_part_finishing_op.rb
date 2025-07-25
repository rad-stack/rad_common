module Pace
  class JobPartFinishingOp < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :active

    attr_accessor :units

    attr_accessor :hours

    attr_accessor :number_helpers

    attr_accessor :component

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part_press_form

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :fiery_property_value

    attr_accessor :fiery_property_value_description

    attr_accessor :created_from_split

    attr_accessor :auto_change

    attr_accessor :fiery_property_description

    attr_accessor :finishing_operation

    attr_accessor :fiery_property

    attr_accessor :quantity

    attr_accessor :binder

    attr_accessor :manual

    attr_accessor :note

    attr_accessor :customer_viewable

    attr_accessor :cutter

    attr_accessor :generic_finishing_machine

    attr_accessor :folded_sheet_size_height_display_uom

    attr_accessor :cover_fold_width

    attr_accessor :folder

    attr_accessor :number_scores

    attr_accessor :qty_per_unit

    attr_accessor :make_ready_hours

    attr_accessor :num_across

    attr_accessor :numbering_start

    attr_accessor :make_ready_spoilage

    attr_accessor :stack_amount

    attr_accessor :barcode_value

    attr_accessor :three_knife

    attr_accessor :folded_sheet_size_height

    attr_accessor :num_up

    attr_accessor :run_speed

    attr_accessor :router

    attr_accessor :num_stagger

    attr_accessor :rotate_stack

    attr_accessor :cutter_alignment_mark_group

    attr_accessor :number_slits

    attr_accessor :number_glues

    attr_accessor :image_shift

    attr_accessor :num_along

    attr_accessor :folded_sheet_size_width_display_uom

    attr_accessor :folder_gap_display_uom

    attr_accessor :review_prompt

    attr_accessor :number_perfs

    attr_accessor :material_vendor

    attr_accessor :cover_fold_width_display_uom

    attr_accessor :num_passes

    attr_accessor :operation_level

    attr_accessor :run_spoilage

    attr_accessor :following_operation_spoilage

    attr_accessor :add_spoilage_sheets

    attr_accessor :padding

    attr_accessor :in_line

    attr_accessor :folded_sheet_size_width

    attr_accessor :quantity_in

    attr_accessor :image_shift_display_uom

    attr_accessor :folder_gap

    attr_accessor :fktag_finishingoperation

    attr_accessor :output_resource_id

    attr_accessor :process_status

    attr_accessor :jdf_submitted

    attr_accessor :queue_entry_id

    attr_accessor :related_job_part_finishing_op


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'active' => :'active',
        :'units' => :'units',
        :'hours' => :'hours',
        :'number_helpers' => :'numberHelpers',
        :'component' => :'component',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part_press_form' => :'jobPartPressForm',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'fiery_property_value' => :'fieryPropertyValue',
        :'fiery_property_value_description' => :'fieryPropertyValueDescription',
        :'created_from_split' => :'createdFromSplit',
        :'auto_change' => :'autoChange',
        :'fiery_property_description' => :'fieryPropertyDescription',
        :'finishing_operation' => :'finishingOperation',
        :'fiery_property' => :'fieryProperty',
        :'quantity' => :'quantity',
        :'binder' => :'binder',
        :'manual' => :'manual',
        :'note' => :'note',
        :'customer_viewable' => :'customerViewable',
        :'cutter' => :'cutter',
        :'generic_finishing_machine' => :'genericFinishingMachine',
        :'folded_sheet_size_height_display_uom' => :'foldedSheetSizeHeightDisplayUOM',
        :'cover_fold_width' => :'coverFoldWidth',
        :'folder' => :'folder',
        :'number_scores' => :'numberScores',
        :'qty_per_unit' => :'qtyPerUnit',
        :'make_ready_hours' => :'makeReadyHours',
        :'num_across' => :'numAcross',
        :'numbering_start' => :'numberingStart',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'stack_amount' => :'stackAmount',
        :'barcode_value' => :'barcodeValue',
        :'three_knife' => :'threeKnife',
        :'folded_sheet_size_height' => :'foldedSheetSizeHeight',
        :'num_up' => :'numUp',
        :'run_speed' => :'runSpeed',
        :'router' => :'router',
        :'num_stagger' => :'numStagger',
        :'rotate_stack' => :'rotateStack',
        :'cutter_alignment_mark_group' => :'cutterAlignmentMarkGroup',
        :'number_slits' => :'numberSlits',
        :'number_glues' => :'numberGlues',
        :'image_shift' => :'imageShift',
        :'num_along' => :'numAlong',
        :'folded_sheet_size_width_display_uom' => :'foldedSheetSizeWidthDisplayUOM',
        :'folder_gap_display_uom' => :'folderGapDisplayUOM',
        :'review_prompt' => :'reviewPrompt',
        :'number_perfs' => :'numberPerfs',
        :'material_vendor' => :'materialVendor',
        :'cover_fold_width_display_uom' => :'coverFoldWidthDisplayUOM',
        :'num_passes' => :'numPasses',
        :'operation_level' => :'operationLevel',
        :'run_spoilage' => :'runSpoilage',
        :'following_operation_spoilage' => :'followingOperationSpoilage',
        :'add_spoilage_sheets' => :'addSpoilageSheets',
        :'padding' => :'padding',
        :'in_line' => :'inLine',
        :'folded_sheet_size_width' => :'foldedSheetSizeWidth',
        :'quantity_in' => :'quantityIn',
        :'image_shift_display_uom' => :'imageShiftDisplayUOM',
        :'folder_gap' => :'folderGap',
        :'fktag_finishingoperation' => :'fktag_finishingoperation',
        :'output_resource_id' => :'outputResourceID',
        :'process_status' => :'processStatus',
        :'jdf_submitted' => :'jdfSubmitted',
        :'queue_entry_id' => :'queueEntryID',
        :'related_job_part_finishing_op' => :'relatedJobPartFinishingOp'
      }
    end
  end
end

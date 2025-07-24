module Pace
  class FoldPattern < Base
    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :number_scores

    attr_accessor :number_slits

    attr_accessor :number_glues

    attr_accessor :number_perfs

    attr_accessor :alt_description

    attr_accessor :odd_panel_spine_size

    attr_accessor :pages

    attr_accessor :pattern_category

    attr_accessor :odd_panel_width_size

    attr_accessor :num_odd_panels_spine

    attr_accessor :num_odd_panels_width

    attr_accessor :spine_size

    attr_accessor :non_image_face

    attr_accessor :non_image_foot

    attr_accessor :non_image_foot_display_uom

    attr_accessor :trim_face

    attr_accessor :bleeds_foot

    attr_accessor :trim_foot

    attr_accessor :tab_head

    attr_accessor :non_image_face_display_uom

    attr_accessor :tab_spine

    attr_accessor :jog_side

    attr_accessor :bleeds_face

    attr_accessor :non_image_spine

    attr_accessor :tab_face

    attr_accessor :non_image_spine_display_uom

    attr_accessor :tab_foot

    attr_accessor :trim_head

    attr_accessor :margin_right

    attr_accessor :trim_spine

    attr_accessor :bleeds_head

    attr_accessor :bleeds_spine

    attr_accessor :binding_side

    attr_accessor :jog_trim

    attr_accessor :jog_trim_display_uom

    attr_accessor :non_image_head

    attr_accessor :non_image_head_display_uom

    attr_accessor :margin_bottom

    attr_accessor :margin_bottom_display_uom

    attr_accessor :margin_right_display_uom

    attr_accessor :can_gate_fold

    attr_accessor :jdf_force_page_one_on_front

    attr_accessor :pattern_number

    attr_accessor :ask_plies

    attr_accessor :must_die_cut

    attr_accessor :imposition_location

    attr_accessor :num_right_angle_folds_pass2

    attr_accessor :metrix_fold_pattern

    attr_accessor :num_folder_plates

    attr_accessor :min_stock_thickness

    attr_accessor :num_right_angle_folds

    attr_accessor :additional_folder_setup_hours

    attr_accessor :num_parallel_folds

    attr_accessor :num_pages_spine_edge

    attr_accessor :max_stock_thickness

    attr_accessor :folder_run_speed_adjust

    attr_accessor :has_spine

    attr_accessor :num_parallel_folds_pass2

    attr_accessor :num_pages_width_edge

    attr_accessor :fiery_multiple_up

    attr_accessor :jdf_type

    attr_accessor :imposition_template

    attr_accessor :num_folder_units


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'number_scores' => :'numberScores',
        :'number_slits' => :'numberSlits',
        :'number_glues' => :'numberGlues',
        :'number_perfs' => :'numberPerfs',
        :'alt_description' => :'altDescription',
        :'odd_panel_spine_size' => :'oddPanelSpineSize',
        :'pages' => :'pages',
        :'pattern_category' => :'patternCategory',
        :'odd_panel_width_size' => :'oddPanelWidthSize',
        :'num_odd_panels_spine' => :'numOddPanelsSpine',
        :'num_odd_panels_width' => :'numOddPanelsWidth',
        :'spine_size' => :'spineSize',
        :'non_image_face' => :'nonImageFace',
        :'non_image_foot' => :'nonImageFoot',
        :'non_image_foot_display_uom' => :'nonImageFootDisplayUOM',
        :'trim_face' => :'trimFace',
        :'bleeds_foot' => :'bleedsFoot',
        :'trim_foot' => :'trimFoot',
        :'tab_head' => :'tabHead',
        :'non_image_face_display_uom' => :'nonImageFaceDisplayUOM',
        :'tab_spine' => :'tabSpine',
        :'jog_side' => :'jogSide',
        :'bleeds_face' => :'bleedsFace',
        :'non_image_spine' => :'nonImageSpine',
        :'tab_face' => :'tabFace',
        :'non_image_spine_display_uom' => :'nonImageSpineDisplayUOM',
        :'tab_foot' => :'tabFoot',
        :'trim_head' => :'trimHead',
        :'margin_right' => :'marginRight',
        :'trim_spine' => :'trimSpine',
        :'bleeds_head' => :'bleedsHead',
        :'bleeds_spine' => :'bleedsSpine',
        :'binding_side' => :'bindingSide',
        :'jog_trim' => :'jogTrim',
        :'jog_trim_display_uom' => :'jogTrimDisplayUOM',
        :'non_image_head' => :'nonImageHead',
        :'non_image_head_display_uom' => :'nonImageHeadDisplayUOM',
        :'margin_bottom' => :'marginBottom',
        :'margin_bottom_display_uom' => :'marginBottomDisplayUOM',
        :'margin_right_display_uom' => :'marginRightDisplayUOM',
        :'can_gate_fold' => :'canGateFold',
        :'jdf_force_page_one_on_front' => :'jdfForcePageOneOnFront',
        :'pattern_number' => :'patternNumber',
        :'ask_plies' => :'askPlies',
        :'must_die_cut' => :'mustDieCut',
        :'imposition_location' => :'impositionLocation',
        :'num_right_angle_folds_pass2' => :'numRightAngleFoldsPass2',
        :'metrix_fold_pattern' => :'metrixFoldPattern',
        :'num_folder_plates' => :'numFolderPlates',
        :'min_stock_thickness' => :'minStockThickness',
        :'num_right_angle_folds' => :'numRightAngleFolds',
        :'additional_folder_setup_hours' => :'additionalFolderSetupHours',
        :'num_parallel_folds' => :'numParallelFolds',
        :'num_pages_spine_edge' => :'numPagesSpineEdge',
        :'max_stock_thickness' => :'maxStockThickness',
        :'folder_run_speed_adjust' => :'folderRunSpeedAdjust',
        :'has_spine' => :'hasSpine',
        :'num_parallel_folds_pass2' => :'numParallelFoldsPass2',
        :'num_pages_width_edge' => :'numPagesWidthEdge',
        :'fiery_multiple_up' => :'fieryMultipleUp',
        :'jdf_type' => :'jdfType',
        :'imposition_template' => :'impositionTemplate',
        :'num_folder_units' => :'numFolderUnits'
      }
    end
  end
end

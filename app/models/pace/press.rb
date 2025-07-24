module Pace
  class Press < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :number_helpers

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :max_length

    attr_accessor :max_image_length_display_uom

    attr_accessor :max_image_length

    attr_accessor :number_helpers_forced

    attr_accessor :metrix_enabled

    attr_accessor :make_ready_activity_code

    attr_accessor :helper_activity_code

    attr_accessor :run_activity_code

    attr_accessor :export_profile

    attr_accessor :roll_change_length

    attr_accessor :two_sided_click_charge_activity_code

    attr_accessor :min_makeready_time

    attr_accessor :dry_other_activity_code

    attr_accessor :max_image_width

    attr_accessor :dry_time_over60

    attr_accessor :min_length

    attr_accessor :auto_select_max_colors

    attr_accessor :click_charge_activity_code

    attr_accessor :double_sided_no_gripper_change

    attr_accessor :varnish_needs_unit

    attr_accessor :make_ready_ink_medium_register

    attr_accessor :large_color_click_charge_activity_code

    attr_accessor :min_length_display_uom

    attr_accessor :surface_n_click_charge_activity_code

    attr_accessor :color_click_charge_activity_code

    attr_accessor :max_width_display_uom

    attr_accessor :make_ready_lift_change_sheets

    attr_accessor :make_ready_side_guide

    attr_accessor :max_width

    attr_accessor :auto_select_min_caliper

    attr_accessor :spoil_over90

    attr_accessor :make_ready_initial_sheets

    attr_accessor :spoil_over120

    attr_accessor :auto_select_max_caliper

    attr_accessor :max_colors_total_per_pass

    attr_accessor :side_allowance

    attr_accessor :min_washup_time

    attr_accessor :gripper_allowance

    attr_accessor :max_washup_time

    attr_accessor :white_click_charge_activity_code

    attr_accessor :make_ready_initial

    attr_accessor :make_ready_coating

    attr_accessor :speed_decrease_over120

    attr_accessor :have_sheeter

    attr_accessor :make_ready_side_guide_sheets

    attr_accessor :min_width_display_uom

    attr_accessor :make_ready_ink_tight_register

    attr_accessor :cut_off_display_uom

    attr_accessor :make_ready_ink_medium_register_sheets

    attr_accessor :side_allowance_display_uom

    attr_accessor :make_ready_ink_no_register_sheets

    attr_accessor :washup_time_pms

    attr_accessor :washup_activity_code

    attr_accessor :coating_sides

    attr_accessor :cut_off

    attr_accessor :washup_time_process

    attr_accessor :plate_thickness

    attr_accessor :washup_time_black

    attr_accessor :jdf_default_press_ink_type

    attr_accessor :spoil_over30

    attr_accessor :material_gap

    attr_accessor :min_width

    attr_accessor :washup_time_varnish

    attr_accessor :roll_change_length_display_uom

    attr_accessor :surface_two_click_charge_activity_code

    attr_accessor :include_mr_sheets_in_run

    attr_accessor :speed_decrease_over90

    attr_accessor :make_ready_ink_tight_register_sheets

    attr_accessor :surface_one_click_charge_activity_code

    attr_accessor :washup_time_forced

    attr_accessor :color_bar_allowance

    attr_accessor :rip_time_activity_code

    attr_accessor :plates_per_revolution

    attr_accessor :washup_time_coating

    attr_accessor :use_max_press_size_as_buy_candidate

    attr_accessor :max_colors_front_per_pass

    attr_accessor :lift_height

    attr_accessor :dry_time_over30

    attr_accessor :make_ready_unit_label

    attr_accessor :separation_click_charge_activity_code

    attr_accessor :repetitive_make_ready_sheets

    attr_accessor :spot_click_charge_activity_code

    attr_accessor :auto_select_min_colors

    attr_accessor :speed_decrease_over30

    attr_accessor :make_ready_lift_change

    attr_accessor :washup_time_standard

    attr_accessor :spoil_over60

    attr_accessor :process_colors_click_charge_activity_code

    attr_accessor :large_click_charge_activity_code

    attr_accessor :core_diameter

    attr_accessor :max_image_width_display_uom

    attr_accessor :max_number_webs

    attr_accessor :core_diameter_display_uom

    attr_accessor :auto_select_min_diff

    attr_accessor :repetitive_make_ready_time

    attr_accessor :varnish_needs_plate

    attr_accessor :max_colors_back_per_pass

    attr_accessor :color_bar_allowance_display_uom

    attr_accessor :press_type

    attr_accessor :speed_decrease_over60

    attr_accessor :max_web_print_units

    attr_accessor :auto_select_max_diff

    attr_accessor :jdf_device_id

    attr_accessor :dry_time_over120

    attr_accessor :dry_time_over90

    attr_accessor :gripper_allowance_display_uom

    attr_accessor :make_ready_gripper_change_sheets

    attr_accessor :material_gap_display_uom

    attr_accessor :make_ready_ink_no_register

    attr_accessor :one_sided_click_charge_activity_code

    attr_accessor :include_run_spoilage_in_run

    attr_accessor :make_ready_coating_sheets

    attr_accessor :impression_click_charge_activity_code

    attr_accessor :min_run_time

    attr_accessor :exclude_mr_press_units_per_pass

    attr_accessor :max_length_display_uom

    attr_accessor :canon_press

    attr_accessor :hppress

    attr_accessor :make_ready_gripper_change


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'number_helpers' => :'numberHelpers',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'max_length' => :'maxLength',
        :'max_image_length_display_uom' => :'maxImageLengthDisplayUOM',
        :'max_image_length' => :'maxImageLength',
        :'number_helpers_forced' => :'numberHelpersForced',
        :'metrix_enabled' => :'metrixEnabled',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'helper_activity_code' => :'helperActivityCode',
        :'run_activity_code' => :'runActivityCode',
        :'export_profile' => :'exportProfile',
        :'roll_change_length' => :'rollChangeLength',
        :'two_sided_click_charge_activity_code' => :'twoSidedClickChargeActivityCode',
        :'min_makeready_time' => :'minMakereadyTime',
        :'dry_other_activity_code' => :'dryOtherActivityCode',
        :'max_image_width' => :'maxImageWidth',
        :'dry_time_over60' => :'dryTimeOver60',
        :'min_length' => :'minLength',
        :'auto_select_max_colors' => :'autoSelectMaxColors',
        :'click_charge_activity_code' => :'clickChargeActivityCode',
        :'double_sided_no_gripper_change' => :'doubleSidedNoGripperChange',
        :'varnish_needs_unit' => :'varnishNeedsUnit',
        :'make_ready_ink_medium_register' => :'makeReadyInkMediumRegister',
        :'large_color_click_charge_activity_code' => :'largeColorClickChargeActivityCode',
        :'min_length_display_uom' => :'minLengthDisplayUOM',
        :'surface_n_click_charge_activity_code' => :'surfaceNClickChargeActivityCode',
        :'color_click_charge_activity_code' => :'colorClickChargeActivityCode',
        :'max_width_display_uom' => :'maxWidthDisplayUOM',
        :'make_ready_lift_change_sheets' => :'makeReadyLiftChangeSheets',
        :'make_ready_side_guide' => :'makeReadySideGuide',
        :'max_width' => :'maxWidth',
        :'auto_select_min_caliper' => :'autoSelectMinCaliper',
        :'spoil_over90' => :'spoilOver90',
        :'make_ready_initial_sheets' => :'makeReadyInitialSheets',
        :'spoil_over120' => :'spoilOver120',
        :'auto_select_max_caliper' => :'autoSelectMaxCaliper',
        :'max_colors_total_per_pass' => :'maxColorsTotalPerPass',
        :'side_allowance' => :'sideAllowance',
        :'min_washup_time' => :'minWashupTime',
        :'gripper_allowance' => :'gripperAllowance',
        :'max_washup_time' => :'maxWashupTime',
        :'white_click_charge_activity_code' => :'whiteClickChargeActivityCode',
        :'make_ready_initial' => :'makeReadyInitial',
        :'make_ready_coating' => :'makeReadyCoating',
        :'speed_decrease_over120' => :'speedDecreaseOver120',
        :'have_sheeter' => :'haveSheeter',
        :'make_ready_side_guide_sheets' => :'makeReadySideGuideSheets',
        :'min_width_display_uom' => :'minWidthDisplayUOM',
        :'make_ready_ink_tight_register' => :'makeReadyInkTightRegister',
        :'cut_off_display_uom' => :'cutOffDisplayUOM',
        :'make_ready_ink_medium_register_sheets' => :'makeReadyInkMediumRegisterSheets',
        :'side_allowance_display_uom' => :'sideAllowanceDisplayUOM',
        :'make_ready_ink_no_register_sheets' => :'makeReadyInkNoRegisterSheets',
        :'washup_time_pms' => :'washupTimePMS',
        :'washup_activity_code' => :'washupActivityCode',
        :'coating_sides' => :'coatingSides',
        :'cut_off' => :'cutOff',
        :'washup_time_process' => :'washupTimeProcess',
        :'plate_thickness' => :'plateThickness',
        :'washup_time_black' => :'washupTimeBlack',
        :'jdf_default_press_ink_type' => :'jdfDefaultPressInkType',
        :'spoil_over30' => :'spoilOver30',
        :'material_gap' => :'materialGap',
        :'min_width' => :'minWidth',
        :'washup_time_varnish' => :'washupTimeVarnish',
        :'roll_change_length_display_uom' => :'rollChangeLengthDisplayUOM',
        :'surface_two_click_charge_activity_code' => :'surfaceTwoClickChargeActivityCode',
        :'include_mr_sheets_in_run' => :'includeMRSheetsInRun',
        :'speed_decrease_over90' => :'speedDecreaseOver90',
        :'make_ready_ink_tight_register_sheets' => :'makeReadyInkTightRegisterSheets',
        :'surface_one_click_charge_activity_code' => :'surfaceOneClickChargeActivityCode',
        :'washup_time_forced' => :'washupTimeForced',
        :'color_bar_allowance' => :'colorBarAllowance',
        :'rip_time_activity_code' => :'ripTimeActivityCode',
        :'plates_per_revolution' => :'platesPerRevolution',
        :'washup_time_coating' => :'washupTimeCoating',
        :'use_max_press_size_as_buy_candidate' => :'useMaxPressSizeAsBuyCandidate',
        :'max_colors_front_per_pass' => :'maxColorsFrontPerPass',
        :'lift_height' => :'liftHeight',
        :'dry_time_over30' => :'dryTimeOver30',
        :'make_ready_unit_label' => :'makeReadyUnitLabel',
        :'separation_click_charge_activity_code' => :'separationClickChargeActivityCode',
        :'repetitive_make_ready_sheets' => :'repetitiveMakeReadySheets',
        :'spot_click_charge_activity_code' => :'spotClickChargeActivityCode',
        :'auto_select_min_colors' => :'autoSelectMinColors',
        :'speed_decrease_over30' => :'speedDecreaseOver30',
        :'make_ready_lift_change' => :'makeReadyLiftChange',
        :'washup_time_standard' => :'washupTimeStandard',
        :'spoil_over60' => :'spoilOver60',
        :'process_colors_click_charge_activity_code' => :'processColorsClickChargeActivityCode',
        :'large_click_charge_activity_code' => :'largeClickChargeActivityCode',
        :'core_diameter' => :'coreDiameter',
        :'max_image_width_display_uom' => :'maxImageWidthDisplayUOM',
        :'max_number_webs' => :'maxNumberWebs',
        :'core_diameter_display_uom' => :'coreDiameterDisplayUOM',
        :'auto_select_min_diff' => :'autoSelectMinDiff',
        :'repetitive_make_ready_time' => :'repetitiveMakeReadyTime',
        :'varnish_needs_plate' => :'varnishNeedsPlate',
        :'max_colors_back_per_pass' => :'maxColorsBackPerPass',
        :'color_bar_allowance_display_uom' => :'colorBarAllowanceDisplayUOM',
        :'press_type' => :'pressType',
        :'speed_decrease_over60' => :'speedDecreaseOver60',
        :'max_web_print_units' => :'maxWebPrintUnits',
        :'auto_select_max_diff' => :'autoSelectMaxDiff',
        :'jdf_device_id' => :'jdfDeviceID',
        :'dry_time_over120' => :'dryTimeOver120',
        :'dry_time_over90' => :'dryTimeOver90',
        :'gripper_allowance_display_uom' => :'gripperAllowanceDisplayUOM',
        :'make_ready_gripper_change_sheets' => :'makeReadyGripperChangeSheets',
        :'material_gap_display_uom' => :'materialGapDisplayUOM',
        :'make_ready_ink_no_register' => :'makeReadyInkNoRegister',
        :'one_sided_click_charge_activity_code' => :'oneSidedClickChargeActivityCode',
        :'include_run_spoilage_in_run' => :'includeRunSpoilageInRun',
        :'make_ready_coating_sheets' => :'makeReadyCoatingSheets',
        :'impression_click_charge_activity_code' => :'impressionClickChargeActivityCode',
        :'min_run_time' => :'minRunTime',
        :'exclude_mr_press_units_per_pass' => :'excludeMRPressUnitsPerPass',
        :'max_length_display_uom' => :'maxLengthDisplayUOM',
        :'canon_press' => :'canonPress',
        :'hppress' => :'hppress',
        :'make_ready_gripper_change' => :'makeReadyGripperChange'
      }
    end
  end
end

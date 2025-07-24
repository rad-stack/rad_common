module Pace
  class Folder < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :make_ready_activity_code

    attr_accessor :machine_type

    attr_accessor :helper_activity_code

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code

    attr_accessor :lift_change

    attr_accessor :lift_height

    attr_accessor :units_per_hour

    attr_accessor :lift_height_display_uom

    attr_accessor :min_size_width

    attr_accessor :max_size_width

    attr_accessor :max_size_width_display_uom

    attr_accessor :max_size_height_display_uom

    attr_accessor :min_size_width_display_uom

    attr_accessor :min_size_height_display_uom

    attr_accessor :min_size_height

    attr_accessor :max_size_height

    attr_accessor :additional_unit_gap

    attr_accessor :gate_fold_spoilage

    attr_accessor :perf_setup

    attr_accessor :lift_change_sheets

    attr_accessor :plate_spoilage

    attr_accessor :glue_setup

    attr_accessor :additional_num_up_setup_sheets

    attr_accessor :score_setup_sheets

    attr_accessor :perf_spoilage

    attr_accessor :additional_unit_gap_display_uom

    attr_accessor :additional_num_up_speed_adjust

    attr_accessor :can_gate_fold

    attr_accessor :first_unit_gap_display_uom

    attr_accessor :max_plates

    attr_accessor :max_units

    attr_accessor :additional_num_up_spoilage

    attr_accessor :score_spoilage

    attr_accessor :first_unit_setup_sheets

    attr_accessor :score_setup

    attr_accessor :right_angle_setup

    attr_accessor :gate_fold_setup_sheets

    attr_accessor :glue_speed_adjust

    attr_accessor :parallel_angle_setup

    attr_accessor :slit_setup_sheets

    attr_accessor :first_unit_spoilage

    attr_accessor :perf_speed_adjust

    attr_accessor :parallel_angle_spoilage

    attr_accessor :slit_setup

    attr_accessor :use_advanced

    attr_accessor :default_num_up

    attr_accessor :additional_unit_spoilage

    attr_accessor :first_unit_gap

    attr_accessor :perf_setup_sheets

    attr_accessor :slit_speed_adjust

    attr_accessor :percent_per_fold

    attr_accessor :first_unit_setup

    attr_accessor :score_speed_adjust

    attr_accessor :slit_spoilage

    attr_accessor :plate_setup_sheets

    attr_accessor :right_angle_slow4

    attr_accessor :first_plate_setup

    attr_accessor :right_angle_slow2

    attr_accessor :right_angle_slow3

    attr_accessor :per_unit_speed_adjust

    attr_accessor :right_angle_spoilage

    attr_accessor :additional_unit_setup

    attr_accessor :gate_fold_setup

    attr_accessor :per_plate_speed_adjust

    attr_accessor :gate_fold_speed_adjust

    attr_accessor :additional_num_up_setup

    attr_accessor :additional_unit_setup_sheets

    attr_accessor :glue_spoilage

    attr_accessor :glue_setup_sheets

    attr_accessor :initial_setup


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'machine_type' => :'machineType',
        :'helper_activity_code' => :'helperActivityCode',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode',
        :'lift_change' => :'liftChange',
        :'lift_height' => :'liftHeight',
        :'units_per_hour' => :'unitsPerHour',
        :'lift_height_display_uom' => :'liftHeightDisplayUOM',
        :'min_size_width' => :'minSizeWidth',
        :'max_size_width' => :'maxSizeWidth',
        :'max_size_width_display_uom' => :'maxSizeWidthDisplayUOM',
        :'max_size_height_display_uom' => :'maxSizeHeightDisplayUOM',
        :'min_size_width_display_uom' => :'minSizeWidthDisplayUOM',
        :'min_size_height_display_uom' => :'minSizeHeightDisplayUOM',
        :'min_size_height' => :'minSizeHeight',
        :'max_size_height' => :'maxSizeHeight',
        :'additional_unit_gap' => :'additionalUnitGap',
        :'gate_fold_spoilage' => :'gateFoldSpoilage',
        :'perf_setup' => :'perfSetup',
        :'lift_change_sheets' => :'liftChangeSheets',
        :'plate_spoilage' => :'plateSpoilage',
        :'glue_setup' => :'glueSetup',
        :'additional_num_up_setup_sheets' => :'additionalNumUpSetupSheets',
        :'score_setup_sheets' => :'scoreSetupSheets',
        :'perf_spoilage' => :'perfSpoilage',
        :'additional_unit_gap_display_uom' => :'additionalUnitGapDisplayUOM',
        :'additional_num_up_speed_adjust' => :'additionalNumUpSpeedAdjust',
        :'can_gate_fold' => :'canGateFold',
        :'first_unit_gap_display_uom' => :'firstUnitGapDisplayUOM',
        :'max_plates' => :'maxPlates',
        :'max_units' => :'maxUnits',
        :'additional_num_up_spoilage' => :'additionalNumUpSpoilage',
        :'score_spoilage' => :'scoreSpoilage',
        :'first_unit_setup_sheets' => :'firstUnitSetupSheets',
        :'score_setup' => :'scoreSetup',
        :'right_angle_setup' => :'rightAngleSetup',
        :'gate_fold_setup_sheets' => :'gateFoldSetupSheets',
        :'glue_speed_adjust' => :'glueSpeedAdjust',
        :'parallel_angle_setup' => :'parallelAngleSetup',
        :'slit_setup_sheets' => :'slitSetupSheets',
        :'first_unit_spoilage' => :'firstUnitSpoilage',
        :'perf_speed_adjust' => :'perfSpeedAdjust',
        :'parallel_angle_spoilage' => :'parallelAngleSpoilage',
        :'slit_setup' => :'slitSetup',
        :'use_advanced' => :'useAdvanced',
        :'default_num_up' => :'defaultNumUp',
        :'additional_unit_spoilage' => :'additionalUnitSpoilage',
        :'first_unit_gap' => :'firstUnitGap',
        :'perf_setup_sheets' => :'perfSetupSheets',
        :'slit_speed_adjust' => :'slitSpeedAdjust',
        :'percent_per_fold' => :'percentPerFold',
        :'first_unit_setup' => :'firstUnitSetup',
        :'score_speed_adjust' => :'scoreSpeedAdjust',
        :'slit_spoilage' => :'slitSpoilage',
        :'plate_setup_sheets' => :'plateSetupSheets',
        :'right_angle_slow4' => :'rightAngleSlow4',
        :'first_plate_setup' => :'firstPlateSetup',
        :'right_angle_slow2' => :'rightAngleSlow2',
        :'right_angle_slow3' => :'rightAngleSlow3',
        :'per_unit_speed_adjust' => :'perUnitSpeedAdjust',
        :'right_angle_spoilage' => :'rightAngleSpoilage',
        :'additional_unit_setup' => :'additionalUnitSetup',
        :'gate_fold_setup' => :'gateFoldSetup',
        :'per_plate_speed_adjust' => :'perPlateSpeedAdjust',
        :'gate_fold_speed_adjust' => :'gateFoldSpeedAdjust',
        :'additional_num_up_setup' => :'additionalNumUpSetup',
        :'additional_unit_setup_sheets' => :'additionalUnitSetupSheets',
        :'glue_spoilage' => :'glueSpoilage',
        :'glue_setup_sheets' => :'glueSetupSheets',
        :'initial_setup' => :'initialSetup'
      }
    end
  end
end

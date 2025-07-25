module Pace
  class Binder < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :note

    attr_accessor :make_ready_activity_code

    attr_accessor :machine_type

    attr_accessor :helper_activity_code

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code

    attr_accessor :additional_num_up_spoilage

    attr_accessor :additional_num_up_setup

    attr_accessor :num_pockets

    attr_accessor :cover_feeder

    attr_accessor :min_trimmed_height_display_uom

    attr_accessor :min_trimmed_width

    attr_accessor :pocket_setup

    attr_accessor :max_trimmed_height

    attr_accessor :min_trimmed_width_display_uom

    attr_accessor :additional_num_up_slowdown

    attr_accessor :max_trimmed_width_display_uom

    attr_accessor :additional_num_up_make_ready

    attr_accessor :base_make_ready

    attr_accessor :max_trimmed_width

    attr_accessor :pocket_make_ready

    attr_accessor :max_trimmed_height_display_uom

    attr_accessor :min_trimmed_height

    attr_accessor :base_setup

    attr_accessor :small_signatures


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
        :'note' => :'note',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'machine_type' => :'machineType',
        :'helper_activity_code' => :'helperActivityCode',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode',
        :'additional_num_up_spoilage' => :'additionalNumUpSpoilage',
        :'additional_num_up_setup' => :'additionalNumUpSetup',
        :'num_pockets' => :'numPockets',
        :'cover_feeder' => :'coverFeeder',
        :'min_trimmed_height_display_uom' => :'minTrimmedHeightDisplayUOM',
        :'min_trimmed_width' => :'minTrimmedWidth',
        :'pocket_setup' => :'pocketSetup',
        :'max_trimmed_height' => :'maxTrimmedHeight',
        :'min_trimmed_width_display_uom' => :'minTrimmedWidthDisplayUOM',
        :'additional_num_up_slowdown' => :'additionalNumUpSlowdown',
        :'max_trimmed_width_display_uom' => :'maxTrimmedWidthDisplayUOM',
        :'additional_num_up_make_ready' => :'additionalNumUpMakeReady',
        :'base_make_ready' => :'baseMakeReady',
        :'max_trimmed_width' => :'maxTrimmedWidth',
        :'pocket_make_ready' => :'pocketMakeReady',
        :'max_trimmed_height_display_uom' => :'maxTrimmedHeightDisplayUOM',
        :'min_trimmed_height' => :'minTrimmedHeight',
        :'base_setup' => :'baseSetup',
        :'small_signatures' => :'smallSignatures'
      }
    end
  end
end

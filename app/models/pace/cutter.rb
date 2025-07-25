module Pace
  class Cutter < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :max_weight

    attr_accessor :make_ready_spoilage

    attr_accessor :run_spoilage_percent

    attr_accessor :make_ready_activity_code

    attr_accessor :machine_type

    attr_accessor :helper_activity_code

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code

    attr_accessor :base_setup_hours

    attr_accessor :min_cuts

    attr_accessor :max_height_display_uom

    attr_accessor :per_cut_time

    attr_accessor :additional_setup_per_cut

    attr_accessor :max_height

    attr_accessor :build_lift_time


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
        :'max_weight' => :'maxWeight',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'run_spoilage_percent' => :'runSpoilagePercent',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'machine_type' => :'machineType',
        :'helper_activity_code' => :'helperActivityCode',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode',
        :'base_setup_hours' => :'baseSetupHours',
        :'min_cuts' => :'minCuts',
        :'max_height_display_uom' => :'maxHeightDisplayUOM',
        :'per_cut_time' => :'perCutTime',
        :'additional_setup_per_cut' => :'additionalSetupPerCut',
        :'max_height' => :'maxHeight',
        :'build_lift_time' => :'buildLiftTime'
      }
    end
  end
end

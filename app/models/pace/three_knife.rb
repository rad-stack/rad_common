module Pace
  class ThreeKnife < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :make_ready_hours

    attr_accessor :make_ready_activity_code

    attr_accessor :machine_type

    attr_accessor :helper_activity_code

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code

    attr_accessor :lift_height

    attr_accessor :lift_height_display_uom

    attr_accessor :min_bound_edge_final_size_display_uom

    attr_accessor :min_bound_edge_final_size

    attr_accessor :lifts_per_hour


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
        :'make_ready_hours' => :'makeReadyHours',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'machine_type' => :'machineType',
        :'helper_activity_code' => :'helperActivityCode',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode',
        :'lift_height' => :'liftHeight',
        :'lift_height_display_uom' => :'liftHeightDisplayUOM',
        :'min_bound_edge_final_size_display_uom' => :'minBoundEdgeFinalSizeDisplayUOM',
        :'min_bound_edge_final_size' => :'minBoundEdgeFinalSize',
        :'lifts_per_hour' => :'liftsPerHour'
      }
    end
  end
end

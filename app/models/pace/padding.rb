module Pace
  class Padding < Base
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

    attr_accessor :material_cost_per_m_pads

    attr_accessor :min_bound_edge_final_size_display_uom

    attr_accessor :pad_speed_per_hour

    attr_accessor :min_bound_edge_final_size

    attr_accessor :max_bound_edge_final_size

    attr_accessor :max_bound_edge_final_size_display_uom


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
        :'material_cost_per_m_pads' => :'materialCostPerMPads',
        :'min_bound_edge_final_size_display_uom' => :'minBoundEdgeFinalSizeDisplayUOM',
        :'pad_speed_per_hour' => :'padSpeedPerHour',
        :'min_bound_edge_final_size' => :'minBoundEdgeFinalSize',
        :'max_bound_edge_final_size' => :'maxBoundEdgeFinalSize',
        :'max_bound_edge_final_size_display_uom' => :'maxBoundEdgeFinalSizeDisplayUOM'
      }
    end
  end
end

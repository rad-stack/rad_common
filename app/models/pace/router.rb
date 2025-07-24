module Pace
  class Router < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :make_ready_spoilage

    attr_accessor :run_spoilage

    attr_accessor :make_ready_activity_code

    attr_accessor :machine_type

    attr_accessor :helper_activity_code

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code

    attr_accessor :units_per_hour

    attr_accessor :min_size_width

    attr_accessor :max_size_width

    attr_accessor :max_size_width_display_uom

    attr_accessor :max_size_height_display_uom

    attr_accessor :make_ready_hours_per_position

    attr_accessor :min_size_width_display_uom

    attr_accessor :min_thickness

    attr_accessor :max_thickness

    attr_accessor :base_setup_hours

    attr_accessor :min_size_height_display_uom

    attr_accessor :min_size_height

    attr_accessor :make_ready_hours_per_sheet

    attr_accessor :max_size_height


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
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'run_spoilage' => :'runSpoilage',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'machine_type' => :'machineType',
        :'helper_activity_code' => :'helperActivityCode',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode',
        :'units_per_hour' => :'unitsPerHour',
        :'min_size_width' => :'minSizeWidth',
        :'max_size_width' => :'maxSizeWidth',
        :'max_size_width_display_uom' => :'maxSizeWidthDisplayUOM',
        :'max_size_height_display_uom' => :'maxSizeHeightDisplayUOM',
        :'make_ready_hours_per_position' => :'makeReadyHoursPerPosition',
        :'min_size_width_display_uom' => :'minSizeWidthDisplayUOM',
        :'min_thickness' => :'minThickness',
        :'max_thickness' => :'maxThickness',
        :'base_setup_hours' => :'baseSetupHours',
        :'min_size_height_display_uom' => :'minSizeHeightDisplayUOM',
        :'min_size_height' => :'minSizeHeight',
        :'make_ready_hours_per_sheet' => :'makeReadyHoursPerSheet',
        :'max_size_height' => :'maxSizeHeight'
      }
    end
  end
end

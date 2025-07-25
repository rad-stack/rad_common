module Pace
  class Plate < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :inventory_item

    attr_accessor :setup_hours

    attr_accessor :material_cost

    attr_accessor :press

    attr_accessor :plate_width_display_uom

    attr_accessor :material_activity_code

    attr_accessor :max_difficulty

    attr_accessor :make_ready_sheets_tight_register

    attr_accessor :plate_life

    attr_accessor :min_difficulty

    attr_accessor :make_ready_hours_tight_register

    attr_accessor :labor_activity_code

    attr_accessor :plate_width

    attr_accessor :make_ready_hours_no_register

    attr_accessor :plate_height

    attr_accessor :plate_height_display_uom

    attr_accessor :make_ready_sheets_medium_register

    attr_accessor :per_burn_hours

    attr_accessor :make_ready_hours_medium_register

    attr_accessor :make_ready_sheets_no_register


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
        :'unit_label' => :'unitLabel',
        :'inventory_item' => :'inventoryItem',
        :'setup_hours' => :'setupHours',
        :'material_cost' => :'materialCost',
        :'press' => :'press',
        :'plate_width_display_uom' => :'plateWidthDisplayUOM',
        :'material_activity_code' => :'materialActivityCode',
        :'max_difficulty' => :'maxDifficulty',
        :'make_ready_sheets_tight_register' => :'makeReadySheetsTightRegister',
        :'plate_life' => :'plateLife',
        :'min_difficulty' => :'minDifficulty',
        :'make_ready_hours_tight_register' => :'makeReadyHoursTightRegister',
        :'labor_activity_code' => :'laborActivityCode',
        :'plate_width' => :'plateWidth',
        :'make_ready_hours_no_register' => :'makeReadyHoursNoRegister',
        :'plate_height' => :'plateHeight',
        :'plate_height_display_uom' => :'plateHeightDisplayUOM',
        :'make_ready_sheets_medium_register' => :'makeReadySheetsMediumRegister',
        :'per_burn_hours' => :'perBurnHours',
        :'make_ready_hours_medium_register' => :'makeReadyHoursMediumRegister',
        :'make_ready_sheets_no_register' => :'makeReadySheetsNoRegister'
      }
    end
  end
end

module Pace
  class PaperSize < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :height_display_uom

    attr_accessor :width

    attr_accessor :width_display_uom

    attr_accessor :height

    attr_accessor :inventory_item

    attr_accessor :manufacturing_locations

    attr_accessor :grain_direction

    attr_accessor :paper_weight

    attr_accessor :carton_qty

    attr_accessor :roll_length

    attr_accessor :roll_diameter

    attr_accessor :roll_diameter_display_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'height_display_uom' => :'heightDisplayUOM',
        :'width' => :'width',
        :'width_display_uom' => :'widthDisplayUOM',
        :'height' => :'height',
        :'inventory_item' => :'inventoryItem',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'grain_direction' => :'grainDirection',
        :'paper_weight' => :'paperWeight',
        :'carton_qty' => :'cartonQty',
        :'roll_length' => :'rollLength',
        :'roll_diameter' => :'rollDiameter',
        :'roll_diameter_display_uom' => :'rollDiameterDisplayUOM'
      }
    end
  end
end

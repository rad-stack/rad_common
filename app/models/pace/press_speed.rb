module Pace
  class PressSpeed < Base
    attr_accessor :id

    attr_accessor :colors_side1

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :speed

    attr_accessor :spoilage

    attr_accessor :size_width_display_uom

    attr_accessor :size_width

    attr_accessor :press

    attr_accessor :size_length

    attr_accessor :size_length_display_uom

    attr_accessor :total_colors

    attr_accessor :speed_factor

    attr_accessor :click_charge_duplex

    attr_accessor :ink_type

    attr_accessor :speed_side2

    attr_accessor :click_charge1_side

    attr_accessor :colors_side2

    attr_accessor :color_click_charge_side2

    attr_accessor :spoilage_side2

    attr_accessor :color_click_charge_side1


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'colors_side1' => :'colorsSide1',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'speed' => :'speed',
        :'spoilage' => :'spoilage',
        :'size_width_display_uom' => :'sizeWidthDisplayUOM',
        :'size_width' => :'sizeWidth',
        :'press' => :'press',
        :'size_length' => :'sizeLength',
        :'size_length_display_uom' => :'sizeLengthDisplayUOM',
        :'total_colors' => :'totalColors',
        :'speed_factor' => :'speedFactor',
        :'click_charge_duplex' => :'clickChargeDuplex',
        :'ink_type' => :'inkType',
        :'speed_side2' => :'speedSide2',
        :'click_charge1_side' => :'clickCharge1Side',
        :'colors_side2' => :'colorsSide2',
        :'color_click_charge_side2' => :'colorClickChargeSide2',
        :'spoilage_side2' => :'spoilageSide2',
        :'color_click_charge_side1' => :'colorClickChargeSide1'
      }
    end
  end
end

module Pace
  class PressFeedDirection < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :height_display_uom

    attr_accessor :width

    attr_accessor :width_display_uom

    attr_accessor :height

    attr_accessor :press

    attr_accessor :orientation

    attr_accessor :binding_side

    attr_accessor :feed_direction

    attr_accessor :bind_type


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
        :'press' => :'press',
        :'orientation' => :'orientation',
        :'binding_side' => :'bindingSide',
        :'feed_direction' => :'feedDirection',
        :'bind_type' => :'bindType'
      }
    end
  end
end

module Pace
  class Size < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :height_display_uom

    attr_accessor :width

    attr_accessor :width_display_uom

    attr_accessor :height


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'type' => :'type',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'height_display_uom' => :'heightDisplayUOM',
        :'width' => :'width',
        :'width_display_uom' => :'widthDisplayUOM',
        :'height' => :'height'
      }
    end
  end
end

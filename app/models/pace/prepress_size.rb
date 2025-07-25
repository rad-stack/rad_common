module Pace
  class PrepressSize < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :size_height_display_uom

    attr_accessor :size_width_display_uom

    attr_accessor :size_height

    attr_accessor :size_width

    attr_accessor :prepress_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'size_height_display_uom' => :'sizeHeightDisplayUOM',
        :'size_width_display_uom' => :'sizeWidthDisplayUOM',
        :'size_height' => :'sizeHeight',
        :'size_width' => :'sizeWidth',
        :'prepress_item' => :'prepressItem'
      }
    end
  end
end

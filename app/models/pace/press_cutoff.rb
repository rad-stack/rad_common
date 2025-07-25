module Pace
  class PressCutoff < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :max_image_length_display_uom

    attr_accessor :max_image_length

    attr_accessor :cutoff

    attr_accessor :cutoff_display_uom

    attr_accessor :press


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'max_image_length_display_uom' => :'maxImageLengthDisplayUOM',
        :'max_image_length' => :'maxImageLength',
        :'cutoff' => :'cutoff',
        :'cutoff_display_uom' => :'cutoffDisplayUOM',
        :'press' => :'press'
      }
    end
  end
end

module Pace
  class AttachmentSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :thumbnail_image_height_on_hover

    attr_accessor :thumbnail_image_width

    attr_accessor :thumbnail_image_height

    attr_accessor :thumbnail_view


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'thumbnail_image_height_on_hover' => :'thumbnailImageHeightOnHover',
        :'thumbnail_image_width' => :'thumbnailImageWidth',
        :'thumbnail_image_height' => :'thumbnailImageHeight',
        :'thumbnail_view' => :'thumbnailView'
      }
    end
  end
end

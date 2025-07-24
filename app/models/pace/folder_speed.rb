module Pace
  class FolderSpeed < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :speed

    attr_accessor :folder

    attr_accessor :up_to_size

    attr_accessor :up_to_size_display_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'speed' => :'speed',
        :'folder' => :'folder',
        :'up_to_size' => :'upToSize',
        :'up_to_size_display_uom' => :'upToSizeDisplayUOM'
      }
    end
  end
end

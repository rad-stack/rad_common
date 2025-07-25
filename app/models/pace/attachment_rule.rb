module Pace
  class AttachmentRule < Base
    attr_accessor :id

    attr_accessor :size

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :file_extension

    attr_accessor :mime_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'size' => :'size',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'file_extension' => :'fileExtension',
        :'mime_type' => :'mimeType'
      }
    end
  end
end

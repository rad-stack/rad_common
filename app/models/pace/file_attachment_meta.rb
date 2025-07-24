module Pace
  class FileAttachmentMeta < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :parent_base_object

    attr_accessor :link

    attr_accessor :parent_base_object_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'parent_base_object' => :'parentBaseObject',
        :'link' => :'link',
        :'parent_base_object_key' => :'parentBaseObjectKey'
      }
    end
  end
end

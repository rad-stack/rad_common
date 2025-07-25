module Pace
  class LocalFileAttachment < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :attachment

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'attachment' => :'attachment',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine'
      }
    end
  end
end

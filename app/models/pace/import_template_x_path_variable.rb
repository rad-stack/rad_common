module Pace
  class ImportTemplateXPathVariable < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :type

    attr_accessor :header

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :import_template

    attr_accessor :import_element


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'type' => :'type',
        :'header' => :'header',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'import_template' => :'importTemplate',
        :'import_element' => :'importElement'
      }
    end
  end
end

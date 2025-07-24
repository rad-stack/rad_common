module Pace
  class UserDefinedView < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :invalid

    attr_accessor :reason

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :view_definition


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'invalid' => :'invalid',
        :'reason' => :'reason',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'view_definition' => :'viewDefinition'
      }
    end
  end
end

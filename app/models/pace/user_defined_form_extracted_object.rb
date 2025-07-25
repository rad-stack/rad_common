module Pace
  class UserDefinedFormExtractedObject < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :user_defined_form


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'user_defined_form' => :'userDefinedForm'
      }
    end
  end
end

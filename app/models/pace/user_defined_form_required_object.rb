module Pace
  class UserDefinedFormRequiredObject < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :user_defined_form

    attr_accessor :context_object


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'user_defined_form' => :'userDefinedForm',
        :'context_object' => :'contextObject'
      }
    end
  end
end

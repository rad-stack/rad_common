module Pace
  class GLRegisterNumber < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_register_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_register_number' => :'glRegisterNumber'
      }
    end
  end
end

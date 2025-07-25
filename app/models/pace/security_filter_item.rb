module Pace
  class SecurityFilterItem < Base
    attr_accessor :id

    attr_accessor :filter_id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :security_filter_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'filter_id' => :'filterId',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'security_filter_key' => :'securityFilterKey'
      }
    end
  end
end

module Pace
  class OrganizationSystemUserCompany < Base
    attr_accessor :user_name

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :organization_company


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'user_name' => :'userName',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'organization_company' => :'organizationCompany'
      }
    end
  end
end

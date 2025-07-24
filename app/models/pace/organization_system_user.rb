module Pace
  class OrganizationSystemUser < Base
    attr_accessor :active

    attr_accessor :user_name

    attr_accessor :password

    attr_accessor :organization

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_company


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'user_name' => :'userName',
        :'password' => :'password',
        :'organization' => :'organization',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_company' => :'defaultCompany'
      }
    end
  end
end

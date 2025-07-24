module Pace
  class CRMUser < Base
    attr_accessor :id

    attr_accessor :password

    attr_accessor :username

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :security_token

    attr_accessor :pace_user


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'password' => :'password',
        :'username' => :'username',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'security_token' => :'securityToken',
        :'pace_user' => :'paceUser'
      }
    end
  end
end

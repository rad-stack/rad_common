module Pace
  class SecurityFilter < Base
    attr_accessor :id

    attr_accessor :group

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :security_filter_type

    attr_accessor :old_user_name

    attr_accessor :exclude_access

    attr_accessor :null_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'group' => :'group',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'security_filter_type' => :'securityFilterType',
        :'old_user_name' => :'oldUserName',
        :'exclude_access' => :'excludeAccess',
        :'null_value' => :'nullValue'
      }
    end
  end
end

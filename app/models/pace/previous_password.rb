module Pace
  class PreviousPassword < Base
    attr_accessor :id

    attr_accessor :password

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_user

    attr_accessor :changed_at


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'password' => :'password',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_user' => :'systemUser',
        :'changed_at' => :'changedAt'
      }
    end
  end
end

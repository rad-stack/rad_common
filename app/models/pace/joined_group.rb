module Pace
  class JoinedGroup < Base
    attr_accessor :user_name

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :secure_id

    attr_accessor :group_name

    attr_accessor :default_menu

    attr_accessor :default_look_and_feel


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'user_name' => :'userName',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'secure_id' => :'secureId',
        :'group_name' => :'groupName',
        :'default_menu' => :'defaultMenu',
        :'default_look_and_feel' => :'defaultLookAndFeel'
      }
    end
  end
end

module Pace
  class RecentItem < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :description

    attr_accessor :url

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :date_time

    attr_accessor :system_user

    attr_accessor :menu_item_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'description' => :'description',
        :'url' => :'url',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'date_time' => :'dateTime',
        :'system_user' => :'systemUser',
        :'menu_item_id' => :'menuItemId'
      }
    end
  end
end

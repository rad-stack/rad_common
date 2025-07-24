module Pace
  class ActivityCodePLQMapping < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :activity_code

    attr_accessor :quote_item_type

    attr_accessor :condition

    attr_accessor :quote_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'activity_code' => :'activityCode',
        :'quote_item_type' => :'quoteItemType',
        :'condition' => :'condition',
        :'quote_category' => :'quoteCategory'
      }
    end
  end
end

module Pace
  class ActivityCodeHotkey < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :keypad

    attr_accessor :activity_code

    attr_accessor :hotkey


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'keypad' => :'keypad',
        :'activity_code' => :'activityCode',
        :'hotkey' => :'hotkey'
      }
    end
  end
end

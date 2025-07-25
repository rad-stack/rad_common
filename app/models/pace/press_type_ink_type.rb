module Pace
  class PressTypeInkType < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :press_type

    attr_accessor :press_ink_type

    attr_accessor :default_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'press_type' => :'pressType',
        :'press_ink_type' => :'pressInkType',
        :'default_type' => :'defaultType'
      }
    end
  end
end

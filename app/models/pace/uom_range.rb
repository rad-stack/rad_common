module Pace
  class UOMRange < Base
    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :uom

    attr_accessor :min_value

    attr_accessor :max_value

    attr_accessor :uom_type

    attr_accessor :next_uom

    attr_accessor :previous_uom

    attr_accessor :auto_range


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'uom' => :'uom',
        :'min_value' => :'minValue',
        :'max_value' => :'maxValue',
        :'uom_type' => :'uomType',
        :'next_uom' => :'nextUOM',
        :'previous_uom' => :'previousUOM',
        :'auto_range' => :'autoRange'
      }
    end
  end
end

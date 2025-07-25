module Pace
  class UOMType < Base
    attr_accessor :active

    attr_accessor :tags

    attr_accessor :dimension

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_display_uom

    attr_accessor :base_uom_imperial

    attr_accessor :display_fractions

    attr_accessor :base_uom_metric


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'tags' => :'tags',
        :'dimension' => :'dimension',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_display_uom' => :'defaultDisplayUOM',
        :'base_uom_imperial' => :'baseUOMImperial',
        :'display_fractions' => :'displayFractions',
        :'base_uom_metric' => :'baseUOMMetric'
      }
    end
  end
end

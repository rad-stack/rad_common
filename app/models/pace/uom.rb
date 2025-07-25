module Pace
  class UOM < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :alt_description

    attr_accessor :measurement_system_conversion_factor

    attr_accessor :template_uom

    attr_accessor :paper_uom

    attr_accessor :abbreviation

    attr_accessor :base_uom_conversion

    attr_accessor :fractional_rounding

    attr_accessor :display_rounding

    attr_accessor :use_as_purchasing_template

    attr_accessor :unit_qty

    attr_accessor :measurement_system

    attr_accessor :purchasing_only

    attr_accessor :estimate_pricing_uom_xpath

    attr_accessor :uom_type


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
        :'system_generated' => :'systemGenerated',
        :'alt_description' => :'altDescription',
        :'measurement_system_conversion_factor' => :'measurementSystemConversionFactor',
        :'template_uom' => :'templateUOM',
        :'paper_uom' => :'paperUOM',
        :'abbreviation' => :'abbreviation',
        :'base_uom_conversion' => :'baseUOMConversion',
        :'fractional_rounding' => :'fractionalRounding',
        :'display_rounding' => :'displayRounding',
        :'use_as_purchasing_template' => :'useAsPurchasingTemplate',
        :'unit_qty' => :'unitQty',
        :'measurement_system' => :'measurementSystem',
        :'purchasing_only' => :'purchasingOnly',
        :'estimate_pricing_uom_xpath' => :'estimatePricingUOMXpath',
        :'uom_type' => :'uomType'
      }
    end
  end
end

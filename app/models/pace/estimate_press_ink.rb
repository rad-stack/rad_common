module Pace
  class EstimatePressInk < Base
    attr_accessor :id

    attr_accessor :units

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_press

    attr_accessor :correlation_id

    attr_accessor :uom

    attr_accessor :units_forced

    attr_accessor :description_forced

    attr_accessor :coverage_back

    attr_accessor :coverage_back_forced

    attr_accessor :ink

    attr_accessor :coverage_front

    attr_accessor :cost_per_unit_forced

    attr_accessor :price_units_uom

    attr_accessor :coverage_front_forced

    attr_accessor :price_units_forced

    attr_accessor :ink_setup_cost

    attr_accessor :price_units

    attr_accessor :cost_per_unit


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'units' => :'units',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_press' => :'estimatePress',
        :'correlation_id' => :'correlationId',
        :'uom' => :'uom',
        :'units_forced' => :'unitsForced',
        :'description_forced' => :'descriptionForced',
        :'coverage_back' => :'coverageBack',
        :'coverage_back_forced' => :'coverageBackForced',
        :'ink' => :'ink',
        :'coverage_front' => :'coverageFront',
        :'cost_per_unit_forced' => :'costPerUnitForced',
        :'price_units_uom' => :'priceUnitsUOM',
        :'coverage_front_forced' => :'coverageFrontForced',
        :'price_units_forced' => :'priceUnitsForced',
        :'ink_setup_cost' => :'inkSetupCost',
        :'price_units' => :'priceUnits',
        :'cost_per_unit' => :'costPerUnit'
      }
    end
  end
end

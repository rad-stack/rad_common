module Pace
  class Ink < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :inventory_item

    attr_accessor :uom

    attr_accessor :run_spoilage

    attr_accessor :activity_code

    attr_accessor :ink_type

    attr_accessor :alt_description

    attr_accessor :press_ink_type

    attr_accessor :cost_per_unit

    attr_accessor :sell_price

    attr_accessor :setup_cost

    attr_accessor :setup_price

    attr_accessor :heavy_coverage

    attr_accessor :washup_factor

    attr_accessor :setup_amount

    attr_accessor :medium_coverage

    attr_accessor :rounding_factor

    attr_accessor :sell_price_uom

    attr_accessor :run_speed_adjustment

    attr_accessor :ink_mileage

    attr_accessor :light_coverage


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
        :'inventory_item' => :'inventoryItem',
        :'uom' => :'uom',
        :'run_spoilage' => :'runSpoilage',
        :'activity_code' => :'activityCode',
        :'ink_type' => :'inkType',
        :'alt_description' => :'altDescription',
        :'press_ink_type' => :'pressInkType',
        :'cost_per_unit' => :'costPerUnit',
        :'sell_price' => :'sellPrice',
        :'setup_cost' => :'setupCost',
        :'setup_price' => :'setupPrice',
        :'heavy_coverage' => :'heavyCoverage',
        :'washup_factor' => :'washupFactor',
        :'setup_amount' => :'setupAmount',
        :'medium_coverage' => :'mediumCoverage',
        :'rounding_factor' => :'roundingFactor',
        :'sell_price_uom' => :'sellPriceUom',
        :'run_speed_adjustment' => :'runSpeedAdjustment',
        :'ink_mileage' => :'inkMileage',
        :'light_coverage' => :'lightCoverage'
      }
    end
  end
end

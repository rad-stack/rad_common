module Pace
  class GenericFinishingMachine < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :number_helpers

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :setup_time

    attr_accessor :speed_adjustment

    attr_accessor :material_cost_per_m

    attr_accessor :make_ready_spoilage

    attr_accessor :setup_material_cost

    attr_accessor :sell_price_per_m

    attr_accessor :make_ready_activity_code

    attr_accessor :sell_setup_price

    attr_accessor :minimum_run_cost

    attr_accessor :machine_type

    attr_accessor :setup_per_signature

    attr_accessor :helper_activity_code

    attr_accessor :alt_description

    attr_accessor :materials_activity_code

    attr_accessor :run_activity_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'number_helpers' => :'numberHelpers',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'setup_time' => :'setupTime',
        :'speed_adjustment' => :'speedAdjustment',
        :'material_cost_per_m' => :'materialCostPerM',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'setup_material_cost' => :'setupMaterialCost',
        :'sell_price_per_m' => :'sellPricePerM',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'sell_setup_price' => :'sellSetupPrice',
        :'minimum_run_cost' => :'minimumRunCost',
        :'machine_type' => :'machineType',
        :'setup_per_signature' => :'setupPerSignature',
        :'helper_activity_code' => :'helperActivityCode',
        :'alt_description' => :'altDescription',
        :'materials_activity_code' => :'materialsActivityCode',
        :'run_activity_code' => :'runActivityCode'
      }
    end
  end
end

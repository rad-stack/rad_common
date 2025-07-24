module Pace
  class BinderSpeed < Base
    attr_accessor :id

    attr_accessor :number_helpers

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :setup_materials_cost

    attr_accessor :speed

    attr_accessor :spoilage

    attr_accessor :pockets

    attr_accessor :material_cost_per_m

    attr_accessor :binder


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'number_helpers' => :'numberHelpers',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'setup_materials_cost' => :'setupMaterialsCost',
        :'speed' => :'speed',
        :'spoilage' => :'spoilage',
        :'pockets' => :'pockets',
        :'material_cost_per_m' => :'materialCostPerM',
        :'binder' => :'binder'
      }
    end
  end
end

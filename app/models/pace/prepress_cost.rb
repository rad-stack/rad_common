module Pace
  class PrepressCost < Base
    attr_accessor :id

    attr_accessor :hours

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :setup_hours

    attr_accessor :material_cost

    attr_accessor :sell_setup_price

    attr_accessor :sell_unit_price

    attr_accessor :prepress_size


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'hours' => :'hours',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'setup_hours' => :'setupHours',
        :'material_cost' => :'materialCost',
        :'sell_setup_price' => :'sellSetupPrice',
        :'sell_unit_price' => :'sellUnitPrice',
        :'prepress_size' => :'prepressSize'
      }
    end
  end
end

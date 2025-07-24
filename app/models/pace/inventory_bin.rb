module Pace
  class InventoryBin < Base
    attr_accessor :length

    attr_accessor :active

    attr_accessor :description

    attr_accessor :group

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :width

    attr_accessor :height

    attr_accessor :max_weight

    attr_accessor :inventory_location

    attr_accessor :coord_x

    attr_accessor :coord_y

    attr_accessor :coord_z

    attr_accessor :bin_class


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'length' => :'length',
        :'active' => :'active',
        :'description' => :'description',
        :'group' => :'group',
        :'tags' => :'tags',
        :'code' => :'code',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'width' => :'width',
        :'height' => :'height',
        :'max_weight' => :'maxWeight',
        :'inventory_location' => :'inventoryLocation',
        :'coord_x' => :'coordX',
        :'coord_y' => :'coordY',
        :'coord_z' => :'coordZ',
        :'bin_class' => :'binClass'
      }
    end
  end
end

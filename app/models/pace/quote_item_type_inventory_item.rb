module Pace
  class QuoteItemTypeInventoryItem < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :inventory_item

    attr_accessor :quote_item_type

    attr_accessor :job_part_item_quantity_calculation

    attr_accessor :price_quantity_calculation

    attr_accessor :default_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'inventory_item' => :'inventoryItem',
        :'quote_item_type' => :'quoteItemType',
        :'job_part_item_quantity_calculation' => :'jobPartItemQuantityCalculation',
        :'price_quantity_calculation' => :'priceQuantityCalculation',
        :'default_item' => :'defaultItem'
      }
    end
  end
end

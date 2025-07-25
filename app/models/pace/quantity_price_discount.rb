module Pace
  class QuantityPriceDiscount < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :price

    attr_accessor :customer

    attr_accessor :inventory_item

    attr_accessor :up_to_quantity

    attr_accessor :setup_price

    attr_accessor :price_discount


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'price' => :'price',
        :'customer' => :'customer',
        :'inventory_item' => :'inventoryItem',
        :'up_to_quantity' => :'upToQuantity',
        :'setup_price' => :'setupPrice',
        :'price_discount' => :'priceDiscount'
      }
    end
  end
end

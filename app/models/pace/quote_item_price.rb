module Pace
  class QuoteItemPrice < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :price

    attr_accessor :unit_price

    attr_accessor :final_price_forced

    attr_accessor :product

    attr_accessor :unit_price_forced

    attr_accessor :flat_price_forced

    attr_accessor :final_price

    attr_accessor :adjust_value_forced

    attr_accessor :price_quantity_forced

    attr_accessor :inventory_unit_price

    attr_accessor :look_up_quantity

    attr_accessor :look_up_quantity_forced

    attr_accessor :price_quantity

    attr_accessor :adjusted_price

    attr_accessor :inventory_unit_price_forced

    attr_accessor :quote_item

    attr_accessor :adjust_value

    attr_accessor :flat_price

    attr_accessor :quote_quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'price' => :'price',
        :'unit_price' => :'unitPrice',
        :'final_price_forced' => :'finalPriceForced',
        :'product' => :'product',
        :'unit_price_forced' => :'unitPriceForced',
        :'flat_price_forced' => :'flatPriceForced',
        :'final_price' => :'finalPrice',
        :'adjust_value_forced' => :'adjustValueForced',
        :'price_quantity_forced' => :'priceQuantityForced',
        :'inventory_unit_price' => :'inventoryUnitPrice',
        :'look_up_quantity' => :'lookUpQuantity',
        :'look_up_quantity_forced' => :'lookUpQuantityForced',
        :'price_quantity' => :'priceQuantity',
        :'adjusted_price' => :'adjustedPrice',
        :'inventory_unit_price_forced' => :'inventoryUnitPriceForced',
        :'quote_item' => :'quoteItem',
        :'adjust_value' => :'adjustValue',
        :'flat_price' => :'flatPrice',
        :'quote_quantity' => :'quoteQuantity'
      }
    end
  end
end

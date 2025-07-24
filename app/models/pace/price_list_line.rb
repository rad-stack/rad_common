module Pace
  class PriceListLine < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :price_list

    attr_accessor :manual

    attr_accessor :unit_price

    attr_accessor :flat_price

    attr_accessor :quote_item_type

    attr_accessor :inventory_markup

    attr_accessor :high_quantity

    attr_accessor :low_quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'price_list' => :'priceList',
        :'manual' => :'manual',
        :'unit_price' => :'unitPrice',
        :'flat_price' => :'flatPrice',
        :'quote_item_type' => :'quoteItemType',
        :'inventory_markup' => :'inventoryMarkup',
        :'high_quantity' => :'highQuantity',
        :'low_quantity' => :'lowQuantity'
      }
    end
  end
end

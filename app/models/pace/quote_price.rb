module Pace
  class QuotePrice < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :price

    attr_accessor :quote

    attr_accessor :final_price_forced

    attr_accessor :final_price

    attr_accessor :adjust_value_forced

    attr_accessor :adjusted_price

    attr_accessor :adjust_value

    attr_accessor :quote_quantity

    attr_accessor :per_m

    attr_accessor :rush_charges

    attr_accessor :shipping_cost

    attr_accessor :final_price_with_shipping

    attr_accessor :base_price


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'price' => :'price',
        :'quote' => :'quote',
        :'final_price_forced' => :'finalPriceForced',
        :'final_price' => :'finalPrice',
        :'adjust_value_forced' => :'adjustValueForced',
        :'adjusted_price' => :'adjustedPrice',
        :'adjust_value' => :'adjustValue',
        :'quote_quantity' => :'quoteQuantity',
        :'per_m' => :'perM',
        :'rush_charges' => :'rushCharges',
        :'shipping_cost' => :'shippingCost',
        :'final_price_with_shipping' => :'finalPriceWithShipping',
        :'base_price' => :'basePrice'
      }
    end
  end
end

module Pace
  class ProductPrice < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :price

    attr_accessor :final_price_forced

    attr_accessor :product

    attr_accessor :final_price

    attr_accessor :adjust_value_forced

    attr_accessor :adjusted_price

    attr_accessor :adjust_value

    attr_accessor :quote_quantity

    attr_accessor :modified_price_based_on_quote_price_override

    attr_accessor :per_m


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'price' => :'price',
        :'final_price_forced' => :'finalPriceForced',
        :'product' => :'product',
        :'final_price' => :'finalPrice',
        :'adjust_value_forced' => :'adjustValueForced',
        :'adjusted_price' => :'adjustedPrice',
        :'adjust_value' => :'adjustValue',
        :'quote_quantity' => :'quoteQuantity',
        :'modified_price_based_on_quote_price_override' => :'modifiedPriceBasedOnQuotePriceOverride',
        :'per_m' => :'perM'
      }
    end
  end
end

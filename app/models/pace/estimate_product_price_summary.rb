module Pace
  class EstimateProductPriceSummary < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :overall_sell_markup

    attr_accessor :overall_markup

    attr_accessor :value_added_markup

    attr_accessor :outside_purchase_markup

    attr_accessor :non_value_added_markup

    attr_accessor :paper_markup

    attr_accessor :quantity

    attr_accessor :price

    attr_accessor :price_per_addl_uom_forced

    attr_accessor :price_per_addl100

    attr_accessor :quoted_price_per_addl100_forced

    attr_accessor :max_payment_term_discount

    attr_accessor :price_per_addl_uom

    attr_accessor :pricing_uom

    attr_accessor :effective_commission_rate_forced

    attr_accessor :price_level

    attr_accessor :non_value_added_price

    attr_accessor :quoted_price

    attr_accessor :tax_base

    attr_accessor :quoted_price_per_addl100

    attr_accessor :quoted_price_per_addl_m

    attr_accessor :quoted_price_per100

    attr_accessor :outside_purchase_markup_forced

    attr_accessor :quoted_price_per_m

    attr_accessor :markup

    attr_accessor :grand_total

    attr_accessor :price_per_addl_m

    attr_accessor :pricing_units_forced

    attr_accessor :quoted_price_forced

    attr_accessor :value_added_price

    attr_accessor :quoted_price_per_addl_each

    attr_accessor :quantity_num

    attr_accessor :tax_amount

    attr_accessor :display_quantity

    attr_accessor :multiple_quantities

    attr_accessor :quantity_ordered

    attr_accessor :value_added_markup_forced

    attr_accessor :debug_beta_price_summary_json

    attr_accessor :debug_beta_price_summary_expected_sell_price

    attr_accessor :outside_purchase_setup_markup

    attr_accessor :overall_sell_markup_forced

    attr_accessor :quoted_price_per_addl_m_forced

    attr_accessor :price_per_uom

    attr_accessor :pricing_units

    attr_accessor :non_value_added_markup_forced

    attr_accessor :outside_purchase_setup_markup_forced

    attr_accessor :quoted_price_per_each

    attr_accessor :cost

    attr_accessor :estimate_product

    attr_accessor :overall_markup_forced

    attr_accessor :paper_markup_forced

    attr_accessor :effective_commission_rate

    attr_accessor :price_per_uom_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'overall_sell_markup' => :'overallSellMarkup',
        :'overall_markup' => :'overallMarkup',
        :'value_added_markup' => :'valueAddedMarkup',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'non_value_added_markup' => :'nonValueAddedMarkup',
        :'paper_markup' => :'paperMarkup',
        :'quantity' => :'quantity',
        :'price' => :'price',
        :'price_per_addl_uom_forced' => :'pricePerAddlUOMForced',
        :'price_per_addl100' => :'pricePerAddl100',
        :'quoted_price_per_addl100_forced' => :'quotedPricePerAddl100Forced',
        :'max_payment_term_discount' => :'maxPaymentTermDiscount',
        :'price_per_addl_uom' => :'pricePerAddlUOM',
        :'pricing_uom' => :'pricingUOM',
        :'effective_commission_rate_forced' => :'effectiveCommissionRateForced',
        :'price_level' => :'priceLevel',
        :'non_value_added_price' => :'nonValueAddedPrice',
        :'quoted_price' => :'quotedPrice',
        :'tax_base' => :'taxBase',
        :'quoted_price_per_addl100' => :'quotedPricePerAddl100',
        :'quoted_price_per_addl_m' => :'quotedPricePerAddlM',
        :'quoted_price_per100' => :'quotedPricePer100',
        :'outside_purchase_markup_forced' => :'outsidePurchaseMarkupForced',
        :'quoted_price_per_m' => :'quotedPricePerM',
        :'markup' => :'markup',
        :'grand_total' => :'grandTotal',
        :'price_per_addl_m' => :'pricePerAddlM',
        :'pricing_units_forced' => :'pricingUnitsForced',
        :'quoted_price_forced' => :'quotedPriceForced',
        :'value_added_price' => :'valueAddedPrice',
        :'quoted_price_per_addl_each' => :'quotedPricePerAddlEach',
        :'quantity_num' => :'quantityNum',
        :'tax_amount' => :'taxAmount',
        :'display_quantity' => :'displayQuantity',
        :'multiple_quantities' => :'multipleQuantities',
        :'quantity_ordered' => :'quantityOrdered',
        :'value_added_markup_forced' => :'valueAddedMarkupForced',
        :'debug_beta_price_summary_json' => :'debugBetaPriceSummaryJSON',
        :'debug_beta_price_summary_expected_sell_price' => :'debugBetaPriceSummaryExpectedSellPrice',
        :'outside_purchase_setup_markup' => :'outsidePurchaseSetupMarkup',
        :'overall_sell_markup_forced' => :'overallSellMarkupForced',
        :'quoted_price_per_addl_m_forced' => :'quotedPricePerAddlMForced',
        :'price_per_uom' => :'pricePerUOM',
        :'pricing_units' => :'pricingUnits',
        :'non_value_added_markup_forced' => :'nonValueAddedMarkupForced',
        :'outside_purchase_setup_markup_forced' => :'outsidePurchaseSetupMarkupForced',
        :'quoted_price_per_each' => :'quotedPricePerEach',
        :'cost' => :'cost',
        :'estimate_product' => :'estimateProduct',
        :'overall_markup_forced' => :'overallMarkupForced',
        :'paper_markup_forced' => :'paperMarkupForced',
        :'effective_commission_rate' => :'effectiveCommissionRate',
        :'price_per_uom_forced' => :'pricePerUOMForced'
      }
    end
  end
end

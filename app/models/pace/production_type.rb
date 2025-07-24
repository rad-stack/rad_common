module Pace
  class ProductionType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :display_non_va_calc_price

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pricing_uom

    attr_accessor :production_type

    attr_accessor :display_pricing_units

    attr_accessor :show_margin_target

    attr_accessor :show_va_target

    attr_accessor :show_addl_unit_price

    attr_accessor :show_va

    attr_accessor :display_price_per_addl100

    attr_accessor :display_va_amount

    attr_accessor :display_term_discount_amount

    attr_accessor :display_price_per_each

    attr_accessor :display_price_per_addl_each

    attr_accessor :show_tax

    attr_accessor :display_price_per_addl_m

    attr_accessor :markup_group_chart

    attr_accessor :sell_group_chart

    attr_accessor :show_unit_price

    attr_accessor :production_type_default

    attr_accessor :display_price_per_m

    attr_accessor :show_margin

    attr_accessor :display_va_percent

    attr_accessor :display_price_per100

    attr_accessor :show_grand_total

    attr_accessor :show_payment_discount

    attr_accessor :show_value_added_chart

    attr_accessor :display_va_calc_price

    attr_accessor :costing_group_chart


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'display_non_va_calc_price' => :'displayNonVACalcPrice',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pricing_uom' => :'pricingUOM',
        :'production_type' => :'productionType',
        :'display_pricing_units' => :'displayPricingUnits',
        :'show_margin_target' => :'showMarginTarget',
        :'show_va_target' => :'showVATarget',
        :'show_addl_unit_price' => :'showAddlUnitPrice',
        :'show_va' => :'showVA',
        :'display_price_per_addl100' => :'displayPricePerAddl100',
        :'display_va_amount' => :'displayVAAmount',
        :'display_term_discount_amount' => :'displayTermDiscountAmount',
        :'display_price_per_each' => :'displayPricePerEach',
        :'display_price_per_addl_each' => :'displayPricePerAddlEach',
        :'show_tax' => :'showTax',
        :'display_price_per_addl_m' => :'displayPricePerAddlM',
        :'markup_group_chart' => :'markupGroupChart',
        :'sell_group_chart' => :'sellGroupChart',
        :'show_unit_price' => :'showUnitPrice',
        :'production_type_default' => :'productionTypeDefault',
        :'display_price_per_m' => :'displayPricePerM',
        :'show_margin' => :'showMargin',
        :'display_va_percent' => :'displayVAPercent',
        :'display_price_per100' => :'displayPricePer100',
        :'show_grand_total' => :'showGrandTotal',
        :'show_payment_discount' => :'showPaymentDiscount',
        :'show_value_added_chart' => :'showValueAddedChart',
        :'display_va_calc_price' => :'displayVACalcPrice',
        :'costing_group_chart' => :'costingGroupChart'
      }
    end
  end
end

module Pace
  class QuoteItemType < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :sales_category

    attr_accessor :customer_viewable

    attr_accessor :uom

    attr_accessor :cost

    attr_accessor :alt_name

    attr_accessor :alt_description

    attr_accessor :ask_quantity_multiplier

    attr_accessor :show_on_invoice_if_zero_dollars

    attr_accessor :default_look_up_quantity_calculation

    attr_accessor :availability

    attr_accessor :variable_inventory_item

    attr_accessor :job_price_quantity_calculation

    attr_accessor :allow_quantity_override

    attr_accessor :estimate_activity_code

    attr_accessor :quantity_label

    attr_accessor :estimating_price_quantity_calculation

    attr_accessor :job_look_up_quantity_calculation

    attr_accessor :interpolate_pricing

    attr_accessor :job_part_item_template

    attr_accessor :allow_discount

    attr_accessor :default_price_quantity_calculation

    attr_accessor :estimating_look_up_quantity_calculation

    attr_accessor :weight_per_piece

    attr_accessor :quick_copy_option


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'sequence' => :'sequence',
        :'sales_category' => :'salesCategory',
        :'customer_viewable' => :'customerViewable',
        :'uom' => :'uom',
        :'cost' => :'cost',
        :'alt_name' => :'altName',
        :'alt_description' => :'altDescription',
        :'ask_quantity_multiplier' => :'askQuantityMultiplier',
        :'show_on_invoice_if_zero_dollars' => :'showOnInvoiceIfZeroDollars',
        :'default_look_up_quantity_calculation' => :'defaultLookUpQuantityCalculation',
        :'availability' => :'availability',
        :'variable_inventory_item' => :'variableInventoryItem',
        :'job_price_quantity_calculation' => :'jobPriceQuantityCalculation',
        :'allow_quantity_override' => :'allowQuantityOverride',
        :'estimate_activity_code' => :'estimateActivityCode',
        :'quantity_label' => :'quantityLabel',
        :'estimating_price_quantity_calculation' => :'estimatingPriceQuantityCalculation',
        :'job_look_up_quantity_calculation' => :'jobLookUpQuantityCalculation',
        :'interpolate_pricing' => :'interpolatePricing',
        :'job_part_item_template' => :'jobPartItemTemplate',
        :'allow_discount' => :'allowDiscount',
        :'default_price_quantity_calculation' => :'defaultPriceQuantityCalculation',
        :'estimating_look_up_quantity_calculation' => :'estimatingLookUpQuantityCalculation',
        :'weight_per_piece' => :'weightPerPiece',
        :'quick_copy_option' => :'quickCopyOption'
      }
    end
  end
end

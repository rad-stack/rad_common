module Pace
  class ItemTemplate < Base
    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :note

    attr_accessor :base_object

    attr_accessor :customer

    attr_accessor :estimate_part

    attr_accessor :quote

    attr_accessor :estimate

    attr_accessor :combo_template

    attr_accessor :alt_description

    attr_accessor :unit_weight

    attr_accessor :legacy_mode

    attr_accessor :qty_options

    attr_accessor :setup_date

    attr_accessor :quote_quantity_usage

    attr_accessor :setup_by

    attr_accessor :item_template_type

    attr_accessor :create_quote

    attr_accessor :quantity_expression

    attr_accessor :auto_recalculate

    attr_accessor :job_description

    attr_accessor :estimate_version

    attr_accessor :quote_product

    attr_accessor :job_product_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'note' => :'note',
        :'base_object' => :'baseObject',
        :'customer' => :'customer',
        :'estimate_part' => :'estimatePart',
        :'quote' => :'quote',
        :'estimate' => :'estimate',
        :'combo_template' => :'comboTemplate',
        :'alt_description' => :'altDescription',
        :'unit_weight' => :'unitWeight',
        :'legacy_mode' => :'legacyMode',
        :'qty_options' => :'qtyOptions',
        :'setup_date' => :'setupDate',
        :'quote_quantity_usage' => :'quoteQuantityUsage',
        :'setup_by' => :'setupBy',
        :'item_template_type' => :'itemTemplateType',
        :'create_quote' => :'createQuote',
        :'quantity_expression' => :'quantityExpression',
        :'auto_recalculate' => :'autoRecalculate',
        :'job_description' => :'jobDescription',
        :'estimate_version' => :'estimateVersion',
        :'quote_product' => :'quoteProduct',
        :'job_product_type' => :'jobProductType'
      }
    end
  end
end

module Pace
  class ChangeOrderLine < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :taxable_code

    attr_accessor :sales_tax

    attr_accessor :tax_base

    attr_accessor :uom

    attr_accessor :tax_amount

    attr_accessor :quote_item

    attr_accessor :flat_price

    attr_accessor :change_order

    attr_accessor :line_type

    attr_accessor :line_num

    attr_accessor :unit_cost

    attr_accessor :qty

    attr_accessor :unit_sell

    attr_accessor :line_bill_flag

    attr_accessor :tax_amount_forced

    attr_accessor :lock_unit_price

    attr_accessor :tax_base_forced

    attr_accessor :shipping_amount

    attr_accessor :nc_amt

    attr_accessor :bill_amt


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'taxable_code' => :'taxableCode',
        :'sales_tax' => :'salesTax',
        :'tax_base' => :'taxBase',
        :'uom' => :'uom',
        :'tax_amount' => :'taxAmount',
        :'quote_item' => :'quoteItem',
        :'flat_price' => :'flatPrice',
        :'change_order' => :'changeOrder',
        :'line_type' => :'lineType',
        :'line_num' => :'lineNum',
        :'unit_cost' => :'unitCost',
        :'qty' => :'qty',
        :'unit_sell' => :'unitSell',
        :'line_bill_flag' => :'lineBillFlag',
        :'tax_amount_forced' => :'taxAmountForced',
        :'lock_unit_price' => :'lockUnitPrice',
        :'tax_base_forced' => :'taxBaseForced',
        :'shipping_amount' => :'shippingAmount',
        :'nc_amt' => :'ncAmt',
        :'bill_amt' => :'billAmt'
      }
    end
  end
end

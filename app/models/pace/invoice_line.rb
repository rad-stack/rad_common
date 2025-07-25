module Pace
  class InvoiceLine < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :posted

    attr_accessor :inventory_item

    attr_accessor :uom

    attr_accessor :cost

    attr_accessor :job_material

    attr_accessor :unit_price

    attr_accessor :flat_price

    attr_accessor :qty_ordered

    attr_accessor :invoice

    attr_accessor :quote_item_type

    attr_accessor :job_part_reference

    attr_accessor :memo_created

    attr_accessor :memo_created_date

    attr_accessor :adjusted_total

    attr_accessor :job_product_reference

    attr_accessor :total_price

    attr_accessor :total_price_adjustment

    attr_accessor :line_type

    attr_accessor :source_data

    attr_accessor :price_changed

    attr_accessor :print_stream_lot_line

    attr_accessor :billing_code

    attr_accessor :qty_invoiced

    attr_accessor :line_num

    attr_accessor :qty_shipped


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
        :'posted' => :'posted',
        :'inventory_item' => :'inventoryItem',
        :'uom' => :'uom',
        :'cost' => :'cost',
        :'job_material' => :'jobMaterial',
        :'unit_price' => :'unitPrice',
        :'flat_price' => :'flatPrice',
        :'qty_ordered' => :'qtyOrdered',
        :'invoice' => :'invoice',
        :'quote_item_type' => :'quoteItemType',
        :'job_part_reference' => :'jobPartReference',
        :'memo_created' => :'memoCreated',
        :'memo_created_date' => :'memoCreatedDate',
        :'adjusted_total' => :'adjustedTotal',
        :'job_product_reference' => :'jobProductReference',
        :'total_price' => :'totalPrice',
        :'total_price_adjustment' => :'totalPriceAdjustment',
        :'line_type' => :'lineType',
        :'source_data' => :'sourceData',
        :'price_changed' => :'priceChanged',
        :'print_stream_lot_line' => :'printStreamLotLine',
        :'billing_code' => :'billingCode',
        :'qty_invoiced' => :'qtyInvoiced',
        :'line_num' => :'lineNum',
        :'qty_shipped' => :'qtyShipped'
      }
    end
  end
end

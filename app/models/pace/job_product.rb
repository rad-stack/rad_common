module Pace
  class JobProduct < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :po_uom

    attr_accessor :qty_to_mfg

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_source

    attr_accessor :proof

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :sales_category

    attr_accessor :tax_category

    attr_accessor :manufacturing_location

    attr_accessor :item_template

    attr_accessor :inventory_item

    attr_accessor :wrap_rear_window

    attr_accessor :second_surface

    attr_accessor :lookup_url

    attr_accessor :material_tags

    attr_accessor :reference1

    attr_accessor :reference2

    attr_accessor :notes5

    attr_accessor :vehicle_year

    attr_accessor :notes4

    attr_accessor :notes3

    attr_accessor :additional_description

    attr_accessor :notes2

    attr_accessor :notes1

    attr_accessor :single_web_delivery

    attr_accessor :vehicle_model

    attr_accessor :user_interface_set

    attr_accessor :vehicle_make

    attr_accessor :preferred_binding_type

    attr_accessor :wrap_side_window

    attr_accessor :wrap_style

    attr_accessor :qty_ordered

    attr_accessor :qty_shipped

    attr_accessor :jdf_submitted

    attr_accessor :original_quoted_price_forced

    attr_accessor :qty_billed

    attr_accessor :pending_billed_amt

    attr_accessor :qty_picked

    attr_accessor :billed_amt

    attr_accessor :original_quoted_price

    attr_accessor :vendor_lot_no

    attr_accessor :lot_expiration_date

    attr_accessor :lot_job_sell_price_per1000

    attr_accessor :change_order_total

    attr_accessor :qty_ordered_forced

    attr_accessor :tax_category_forced

    attr_accessor :dsf_pull_ticket_id

    attr_accessor :product_value

    attr_accessor :sales_category_forced

    attr_accessor :invoice_uom_forced

    attr_accessor :invoice_uom

    attr_accessor :freight_amount_total

    attr_accessor :qty_remaining

    attr_accessor :amount_to_invoice_forced

    attr_accessor :arn_sent

    attr_accessor :amount_invoiced

    attr_accessor :w2p_line_item_id

    attr_accessor :parent_job_product

    attr_accessor :amount_to_invoice

    attr_accessor :print_stream_pull_ticket_id

    attr_accessor :price_per_pouom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'po_uom' => :'poUom',
        :'qty_to_mfg' => :'qtyToMfg',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_source' => :'estimateSource',
        :'proof' => :'proof',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'sales_category' => :'salesCategory',
        :'tax_category' => :'taxCategory',
        :'manufacturing_location' => :'manufacturingLocation',
        :'item_template' => :'itemTemplate',
        :'inventory_item' => :'inventoryItem',
        :'wrap_rear_window' => :'wrapRearWindow',
        :'second_surface' => :'secondSurface',
        :'lookup_url' => :'lookupURL',
        :'material_tags' => :'materialTags',
        :'reference1' => :'reference1',
        :'reference2' => :'reference2',
        :'notes5' => :'notes5',
        :'vehicle_year' => :'vehicleYear',
        :'notes4' => :'notes4',
        :'notes3' => :'notes3',
        :'additional_description' => :'additionalDescription',
        :'notes2' => :'notes2',
        :'notes1' => :'notes1',
        :'single_web_delivery' => :'singleWebDelivery',
        :'vehicle_model' => :'vehicleModel',
        :'user_interface_set' => :'userInterfaceSet',
        :'vehicle_make' => :'vehicleMake',
        :'preferred_binding_type' => :'preferredBindingType',
        :'wrap_side_window' => :'wrapSideWindow',
        :'wrap_style' => :'wrapStyle',
        :'qty_ordered' => :'qtyOrdered',
        :'qty_shipped' => :'qtyShipped',
        :'jdf_submitted' => :'jdfSubmitted',
        :'original_quoted_price_forced' => :'originalQuotedPriceForced',
        :'qty_billed' => :'qtyBilled',
        :'pending_billed_amt' => :'pendingBilledAmt',
        :'qty_picked' => :'qtyPicked',
        :'billed_amt' => :'billedAmt',
        :'original_quoted_price' => :'originalQuotedPrice',
        :'vendor_lot_no' => :'vendorLotNo',
        :'lot_expiration_date' => :'lotExpirationDate',
        :'lot_job_sell_price_per1000' => :'lotJobSellPricePer1000',
        :'change_order_total' => :'changeOrderTotal',
        :'qty_ordered_forced' => :'qtyOrderedForced',
        :'tax_category_forced' => :'taxCategoryForced',
        :'dsf_pull_ticket_id' => :'dsfPullTicketID',
        :'product_value' => :'productValue',
        :'sales_category_forced' => :'salesCategoryForced',
        :'invoice_uom_forced' => :'invoiceUOMForced',
        :'invoice_uom' => :'invoiceUOM',
        :'freight_amount_total' => :'freightAmountTotal',
        :'qty_remaining' => :'qtyRemaining',
        :'amount_to_invoice_forced' => :'amountToInvoiceForced',
        :'arn_sent' => :'arnSent',
        :'amount_invoiced' => :'amountInvoiced',
        :'w2p_line_item_id' => :'w2pLineItemId',
        :'parent_job_product' => :'parentJobProduct',
        :'amount_to_invoice' => :'amountToInvoice',
        :'print_stream_pull_ticket_id' => :'printStreamPullTicketID',
        :'price_per_pouom' => :'pricePerPOUOM'
      }
    end
  end
end

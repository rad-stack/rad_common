module Pace
  class PurchaseOrderReceipt < Base
    attr_accessor :id

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :note

    attr_accessor :date_time

    attr_accessor :purchase_order_line

    attr_accessor :extended_price

    attr_accessor :serial_id

    attr_accessor :accrual_cost

    attr_accessor :accrual_billed

    attr_accessor :ap_unit_cost

    attr_accessor :ap_date

    attr_accessor :stocking_uom

    attr_accessor :billed_amount

    attr_accessor :alt_currency_unit_cost

    attr_accessor :variance

    attr_accessor :unit_cost

    attr_accessor :billed_quantity

    attr_accessor :ap_quantity

    attr_accessor :print_stream_receipt_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'note' => :'note',
        :'date_time' => :'dateTime',
        :'purchase_order_line' => :'purchaseOrderLine',
        :'extended_price' => :'extendedPrice',
        :'serial_id' => :'serialID',
        :'accrual_cost' => :'accrualCost',
        :'accrual_billed' => :'accrualBilled',
        :'ap_unit_cost' => :'apUnitCost',
        :'ap_date' => :'apDate',
        :'stocking_uom' => :'stockingUOM',
        :'billed_amount' => :'billedAmount',
        :'alt_currency_unit_cost' => :'altCurrencyUnitCost',
        :'variance' => :'variance',
        :'unit_cost' => :'unitCost',
        :'billed_quantity' => :'billedQuantity',
        :'ap_quantity' => :'apQuantity',
        :'print_stream_receipt_id' => :'printStreamReceiptID'
      }
    end
  end
end

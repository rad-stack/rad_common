module Pace
  class PurchaseOrderLine < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :lot

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :dsf_shared

    attr_accessor :print_stream_shared

    attr_accessor :addl_desc

    attr_accessor :inventory_item

    attr_accessor :gl_account

    attr_accessor :po_number

    attr_accessor :size_width_display_uom

    attr_accessor :size_width

    attr_accessor :taxable

    attr_accessor :uom

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :job_material

    attr_accessor :unit_price

    attr_accessor :unit_price_forced

    attr_accessor :activity_code

    attr_accessor :qty_ordered

    attr_accessor :size_length

    attr_accessor :size_length_display_uom

    attr_accessor :total_weight

    attr_accessor :purchase_order

    attr_accessor :vendor_part_number

    attr_accessor :line_type

    attr_accessor :grain_direction

    attr_accessor :revision

    attr_accessor :paper_sheet

    attr_accessor :paper_caliper

    attr_accessor :rmanumber

    attr_accessor :tax_base2_forced

    attr_accessor :vendor_lot_no

    attr_accessor :invoice_complete

    attr_accessor :qty_received

    attr_accessor :lot_expiration_date

    attr_accessor :paper_brand

    attr_accessor :qty_uom

    attr_accessor :extended_price

    attr_accessor :invoice_unit_price

    attr_accessor :paper_finish

    attr_accessor :paper_type

    attr_accessor :tax_amount1

    attr_accessor :tax_amount2

    attr_accessor :vendor_item

    attr_accessor :date_entered

    attr_accessor :job_part_outside_purch

    attr_accessor :external_line_num

    attr_accessor :num_serial_ids

    attr_accessor :invoice_qty

    attr_accessor :tax_amount1_forced

    attr_accessor :qty_last_received

    attr_accessor :gl_credit_account

    attr_accessor :item_type

    attr_accessor :stock_number

    attr_accessor :old_glid

    attr_accessor :rmadate

    attr_accessor :tax_base2

    attr_accessor :taxable_code1

    attr_accessor :tax_base1

    attr_accessor :line_status

    attr_accessor :tax_base1_forced

    attr_accessor :old_gl_location

    attr_accessor :paper_basis

    attr_accessor :date_required

    attr_accessor :related_line_for_line

    attr_accessor :receiving_note

    attr_accessor :invoice_unit_price_uom

    attr_accessor :paper_color

    attr_accessor :inventory_bin_key

    attr_accessor :sales_tax_rate1

    attr_accessor :quantity_to_receive

    attr_accessor :sales_tax_rate2

    attr_accessor :tax_amount2_forced

    attr_accessor :invoice_num

    attr_accessor :rmacredit_date

    attr_accessor :time_required

    attr_accessor :lot_job_sell_price_per1000

    attr_accessor :quote_num

    attr_accessor :taxable_code2

    attr_accessor :reason_id

    attr_accessor :serial_id

    attr_accessor :mweight


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'lot' => :'lot',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'dsf_shared' => :'dsfShared',
        :'print_stream_shared' => :'printStreamShared',
        :'addl_desc' => :'addlDesc',
        :'inventory_item' => :'inventoryItem',
        :'gl_account' => :'glAccount',
        :'po_number' => :'poNumber',
        :'size_width_display_uom' => :'sizeWidthDisplayUOM',
        :'size_width' => :'sizeWidth',
        :'taxable' => :'taxable',
        :'uom' => :'uom',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'job_material' => :'jobMaterial',
        :'unit_price' => :'unitPrice',
        :'unit_price_forced' => :'unitPriceForced',
        :'activity_code' => :'activityCode',
        :'qty_ordered' => :'qtyOrdered',
        :'size_length' => :'sizeLength',
        :'size_length_display_uom' => :'sizeLengthDisplayUOM',
        :'total_weight' => :'totalWeight',
        :'purchase_order' => :'purchaseOrder',
        :'vendor_part_number' => :'vendorPartNumber',
        :'line_type' => :'lineType',
        :'grain_direction' => :'grainDirection',
        :'revision' => :'revision',
        :'paper_sheet' => :'paperSheet',
        :'paper_caliper' => :'paperCaliper',
        :'rmanumber' => :'rmanumber',
        :'tax_base2_forced' => :'taxBase2Forced',
        :'vendor_lot_no' => :'vendorLotNo',
        :'invoice_complete' => :'invoiceComplete',
        :'qty_received' => :'qtyReceived',
        :'lot_expiration_date' => :'lotExpirationDate',
        :'paper_brand' => :'paperBrand',
        :'qty_uom' => :'qtyUom',
        :'extended_price' => :'extendedPrice',
        :'invoice_unit_price' => :'invoiceUnitPrice',
        :'paper_finish' => :'paperFinish',
        :'paper_type' => :'paperType',
        :'tax_amount1' => :'taxAmount1',
        :'tax_amount2' => :'taxAmount2',
        :'vendor_item' => :'vendorItem',
        :'date_entered' => :'dateEntered',
        :'job_part_outside_purch' => :'jobPartOutsidePurch',
        :'external_line_num' => :'externalLineNum',
        :'num_serial_ids' => :'numSerialIDs',
        :'invoice_qty' => :'invoiceQty',
        :'tax_amount1_forced' => :'taxAmount1Forced',
        :'qty_last_received' => :'qtyLastReceived',
        :'gl_credit_account' => :'glCreditAccount',
        :'item_type' => :'itemType',
        :'stock_number' => :'stockNumber',
        :'old_glid' => :'oldGLId',
        :'rmadate' => :'rmadate',
        :'tax_base2' => :'taxBase2',
        :'taxable_code1' => :'taxableCode1',
        :'tax_base1' => :'taxBase1',
        :'line_status' => :'lineStatus',
        :'tax_base1_forced' => :'taxBase1Forced',
        :'old_gl_location' => :'oldGLLocation',
        :'paper_basis' => :'paperBasis',
        :'date_required' => :'dateRequired',
        :'related_line_for_line' => :'relatedLineForLine',
        :'receiving_note' => :'receivingNote',
        :'invoice_unit_price_uom' => :'invoiceUnitPriceUOM',
        :'paper_color' => :'paperColor',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'sales_tax_rate1' => :'salesTaxRate1',
        :'quantity_to_receive' => :'quantityToReceive',
        :'sales_tax_rate2' => :'salesTaxRate2',
        :'tax_amount2_forced' => :'taxAmount2Forced',
        :'invoice_num' => :'invoiceNum',
        :'rmacredit_date' => :'rmacreditDate',
        :'time_required' => :'timeRequired',
        :'lot_job_sell_price_per1000' => :'lotJobSellPricePer1000',
        :'quote_num' => :'quoteNum',
        :'taxable_code2' => :'taxableCode2',
        :'reason_id' => :'reasonID',
        :'serial_id' => :'serialID',
        :'mweight' => :'mweight'
      }
    end
  end
end

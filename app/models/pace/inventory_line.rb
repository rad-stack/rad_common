module Pace
  class InventoryLine < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :line_number

    attr_accessor :lot

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :quantity

    attr_accessor :employee_time

    attr_accessor :entered_by

    attr_accessor :posted

    attr_accessor :employee

    attr_accessor :transaction_type

    attr_accessor :gl_accounting_period

    attr_accessor :inventory_item

    attr_accessor :posting_status

    attr_accessor :uom

    attr_accessor :date_time

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :non_planned_reason

    attr_accessor :unit_price

    attr_accessor :activity_code

    attr_accessor :job_cost

    attr_accessor :purchase_order_line

    attr_accessor :journal_code

    attr_accessor :postable

    attr_accessor :edit_flag

    attr_accessor :purchase_order

    attr_accessor :quantity_remaining

    attr_accessor :total_cost

    attr_accessor :edit_date

    attr_accessor :revision

    attr_accessor :qty_uom

    attr_accessor :num_serial_ids

    attr_accessor :inventory_bin_key

    attr_accessor :serial_id

    attr_accessor :mweight

    attr_accessor :pick_ticket_id

    attr_accessor :print_stream_receipt_id

    attr_accessor :update_inventory_item_cost

    attr_accessor :entered_quantity

    attr_accessor :needs_review

    attr_accessor :needs_review_note

    attr_accessor :remaining_cost

    attr_accessor :transfer_to_inventory_location

    attr_accessor :posted_flag

    attr_accessor :inventory_description

    attr_accessor :serial_id_has_transactions

    attr_accessor :sequence_number

    attr_accessor :trans_description

    attr_accessor :original_inventory_line

    attr_accessor :from_location

    attr_accessor :actual_count_on_enter

    attr_accessor :source_job_shipment

    attr_accessor :adjusted_line

    attr_accessor :transfer_to_inventory_bin_key

    attr_accessor :inventory_batch

    attr_accessor :old_gl_accounting_period

    attr_accessor :serial_id_quantity_available

    attr_accessor :old_gll_fiscal_year

    attr_accessor :transfer_to_inventory_bin

    attr_accessor :cost_variance

    attr_accessor :serial_id_quantity_allocated

    attr_accessor :lot_cycle_count_key

    attr_accessor :source_material

    attr_accessor :source_inventory_line

    attr_accessor :receipt_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'line_number' => :'lineNumber',
        :'lot' => :'lot',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'quantity' => :'quantity',
        :'employee_time' => :'employeeTime',
        :'entered_by' => :'enteredBy',
        :'posted' => :'posted',
        :'employee' => :'employee',
        :'transaction_type' => :'transactionType',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'inventory_item' => :'inventoryItem',
        :'posting_status' => :'postingStatus',
        :'uom' => :'uom',
        :'date_time' => :'dateTime',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'non_planned_reason' => :'nonPlannedReason',
        :'unit_price' => :'unitPrice',
        :'activity_code' => :'activityCode',
        :'job_cost' => :'jobCost',
        :'purchase_order_line' => :'purchaseOrderLine',
        :'journal_code' => :'journalCode',
        :'postable' => :'postable',
        :'edit_flag' => :'editFlag',
        :'purchase_order' => :'purchaseOrder',
        :'quantity_remaining' => :'quantityRemaining',
        :'total_cost' => :'totalCost',
        :'edit_date' => :'editDate',
        :'revision' => :'revision',
        :'qty_uom' => :'qtyUom',
        :'num_serial_ids' => :'numSerialIDs',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'serial_id' => :'serialID',
        :'mweight' => :'mweight',
        :'pick_ticket_id' => :'pickTicketId',
        :'print_stream_receipt_id' => :'printStreamReceiptID',
        :'update_inventory_item_cost' => :'updateInventoryItemCost',
        :'entered_quantity' => :'enteredQuantity',
        :'needs_review' => :'needsReview',
        :'needs_review_note' => :'needsReviewNote',
        :'remaining_cost' => :'remainingCost',
        :'transfer_to_inventory_location' => :'transferToInventoryLocation',
        :'posted_flag' => :'postedFlag',
        :'inventory_description' => :'inventoryDescription',
        :'serial_id_has_transactions' => :'serialIdHasTransactions',
        :'sequence_number' => :'sequenceNumber',
        :'trans_description' => :'transDescription',
        :'original_inventory_line' => :'originalInventoryLine',
        :'from_location' => :'fromLocation',
        :'actual_count_on_enter' => :'actualCountOnEnter',
        :'source_job_shipment' => :'sourceJobShipment',
        :'adjusted_line' => :'adjustedLine',
        :'transfer_to_inventory_bin_key' => :'transferToInventoryBinKey',
        :'inventory_batch' => :'inventoryBatch',
        :'old_gl_accounting_period' => :'oldGLAccountingPeriod',
        :'serial_id_quantity_available' => :'serialIDQuantityAvailable',
        :'old_gll_fiscal_year' => :'oldGLLFiscalYear',
        :'transfer_to_inventory_bin' => :'transferToInventoryBin',
        :'cost_variance' => :'costVariance',
        :'serial_id_quantity_allocated' => :'serialIDQuantityAllocated',
        :'lot_cycle_count_key' => :'lotCycleCountKey',
        :'source_material' => :'sourceMaterial',
        :'source_inventory_line' => :'sourceInventoryLine',
        :'receipt_id' => :'receiptID'
      }
    end
  end
end

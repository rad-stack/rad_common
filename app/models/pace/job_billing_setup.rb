module Pace
  class JobBillingSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :consolidate_invoices

    attr_accessor :credit_check

    attr_accessor :invoice_message

    attr_accessor :invoice_number

    attr_accessor :allow_process_all

    attr_accessor :change_order

    attr_accessor :use_manufacturing_location_prefix

    attr_accessor :job_part_reference

    attr_accessor :invoice_prefix

    attr_accessor :invoice_date_method

    attr_accessor :itemized_invoicing

    attr_accessor :one_source_asynchronous_threshold

    attr_accessor :under_message

    attr_accessor :bill_part_one_only

    attr_accessor :alt_over_message

    attr_accessor :remit_to_contact

    attr_accessor :alt_invoice_message

    attr_accessor :commission_basis_type

    attr_accessor :auto_bill_when_all_parts_status_bill_ok

    attr_accessor :credit_memo_as_new_invoice

    attr_accessor :force_print_stream_invoice_totals

    attr_accessor :allow_manual_deposits

    attr_accessor :reversal_invoice_type

    attr_accessor :use_unique_invoice_sequence

    attr_accessor :default_billing_job_type

    attr_accessor :invoice_exists_warn

    attr_accessor :memo_invoice_type

    attr_accessor :enable_quick_invoice

    attr_accessor :alt_under_message

    attr_accessor :over_message


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'consolidate_invoices' => :'consolidateInvoices',
        :'credit_check' => :'creditCheck',
        :'invoice_message' => :'invoiceMessage',
        :'invoice_number' => :'invoiceNumber',
        :'allow_process_all' => :'allowProcessAll',
        :'change_order' => :'changeOrder',
        :'use_manufacturing_location_prefix' => :'useManufacturingLocationPrefix',
        :'job_part_reference' => :'jobPartReference',
        :'invoice_prefix' => :'invoicePrefix',
        :'invoice_date_method' => :'invoiceDateMethod',
        :'itemized_invoicing' => :'itemizedInvoicing',
        :'one_source_asynchronous_threshold' => :'oneSourceAsynchronousThreshold',
        :'under_message' => :'underMessage',
        :'bill_part_one_only' => :'billPartOneOnly',
        :'alt_over_message' => :'altOverMessage',
        :'remit_to_contact' => :'remitToContact',
        :'alt_invoice_message' => :'altInvoiceMessage',
        :'commission_basis_type' => :'commissionBasisType',
        :'auto_bill_when_all_parts_status_bill_ok' => :'autoBillWhenAllPartsStatusBillOk',
        :'credit_memo_as_new_invoice' => :'creditMemoAsNewInvoice',
        :'force_print_stream_invoice_totals' => :'forcePrintStreamInvoiceTotals',
        :'allow_manual_deposits' => :'allowManualDeposits',
        :'reversal_invoice_type' => :'reversalInvoiceType',
        :'use_unique_invoice_sequence' => :'useUniqueInvoiceSequence',
        :'default_billing_job_type' => :'defaultBillingJobType',
        :'invoice_exists_warn' => :'invoiceExistsWarn',
        :'memo_invoice_type' => :'memoInvoiceType',
        :'enable_quick_invoice' => :'enableQuickInvoice',
        :'alt_under_message' => :'altUnderMessage',
        :'over_message' => :'overMessage'
      }
    end
  end
end

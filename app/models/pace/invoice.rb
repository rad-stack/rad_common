module Pace
  class Invoice < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :reversal_of

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :invoice_date

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :sales_category

    attr_accessor :contact_last_name

    attr_accessor :bill_to_contact

    attr_accessor :contact_first_name

    attr_accessor :ship_via

    attr_accessor :dsf_shared

    attr_accessor :taxable_code

    attr_accessor :terms

    attr_accessor :sales_person

    attr_accessor :sales_tax

    attr_accessor :legal_entity

    attr_accessor :print_stream_shared

    attr_accessor :ship_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :ship_to_format

    attr_accessor :balanced

    attr_accessor :entered_by

    attr_accessor :posted

    attr_accessor :customer

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :invoice_amount

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :review

    attr_accessor :po_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :exported_to3rd_party

    attr_accessor :tax_base

    attr_accessor :tax_amount

    attr_accessor :quantity_ordered

    attr_accessor :charge_back_account

    attr_accessor :calculating

    attr_accessor :commission_rate

    attr_accessor :receivable

    attr_accessor :target_sell

    attr_accessor :commission_base

    attr_accessor :total_cost

    attr_accessor :actual_ship_date

    attr_accessor :invoice_num

    attr_accessor :debit_credit_reason

    attr_accessor :discount_base

    attr_accessor :commission_amount

    attr_accessor :freight_amount

    attr_accessor :discount_base_forced

    attr_accessor :business_unit

    attr_accessor :form_number

    attr_accessor :tax_distribution_source

    attr_accessor :distribute_tax

    attr_accessor :invoice_level_options

    attr_accessor :sales_distribution_method

    attr_accessor :tax_distribution_method

    attr_accessor :sales_tax_basis

    attr_accessor :commission_distribution_method

    attr_accessor :commission_distribution_source

    attr_accessor :value_added

    attr_accessor :quantity_shipped

    attr_accessor :use_vat

    attr_accessor :distribution_remaining

    attr_accessor :reversal_reason

    attr_accessor :adjusted_invoice_amount

    attr_accessor :itemized

    attr_accessor :lock_commission_amount

    attr_accessor :deposit_amount

    attr_accessor :handling_from_carton_content

    attr_accessor :quick_invoice

    attr_accessor :tax_base_adjustment

    attr_accessor :distribute_commission

    attr_accessor :invoice_batch

    attr_accessor :send_as_pre_invoice

    attr_accessor :value_added_forced

    attr_accessor :products_to_invoice

    attr_accessor :previous_admin_status

    attr_accessor :tax_base_adjustment_forced

    attr_accessor :lock_commission_base

    attr_accessor :freight_from_carton_content

    attr_accessor :memo_approved

    attr_accessor :next_line_num

    attr_accessor :balance_amount

    attr_accessor :submitted_to_onesource

    attr_accessor :memo_of

    attr_accessor :reversal_in_process

    attr_accessor :taxing_failed

    attr_accessor :consolidation_group

    attr_accessor :commission_base_adjustment_forced

    attr_accessor :split_from_invoice

    attr_accessor :close_job

    attr_accessor :previous_production_status

    attr_accessor :lock_customer_discount

    attr_accessor :tax_amount_adjustment

    attr_accessor :existing_memos

    attr_accessor :percent_wip_to_relieve

    attr_accessor :invoice_type

    attr_accessor :partially_bill

    attr_accessor :taxing_required

    attr_accessor :commission_base_adjustment

    attr_accessor :total_extras

    attr_accessor :commission_amount_adjustment

    attr_accessor :lock_tax_amount

    attr_accessor :post_completed

    attr_accessor :parts_to_invoice

    attr_accessor :lock_tax_base

    attr_accessor :memo_accounting_period

    attr_accessor :line_item_total

    attr_accessor :split_original_invoice_amount

    attr_accessor :memo_committed

    attr_accessor :memo_adjustment

    attr_accessor :show_quick_invoice_report

    attr_accessor :invoice_job_parts

    attr_accessor :invoice_amount_adjustment

    attr_accessor :posting

    attr_accessor :value_added_cost

    attr_accessor :exclude_from_consolidation

    attr_accessor :commission_sales_category

    attr_accessor :taxing_in_progress

    attr_accessor :memo_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'reversal_of' => :'reversalOf',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'invoice_date' => :'invoiceDate',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'sales_category' => :'salesCategory',
        :'contact_last_name' => :'contactLastName',
        :'bill_to_contact' => :'billToContact',
        :'contact_first_name' => :'contactFirstName',
        :'ship_via' => :'shipVia',
        :'dsf_shared' => :'dsfShared',
        :'taxable_code' => :'taxableCode',
        :'terms' => :'terms',
        :'sales_person' => :'salesPerson',
        :'sales_tax' => :'salesTax',
        :'legal_entity' => :'legalEntity',
        :'print_stream_shared' => :'printStreamShared',
        :'ship_to_contact' => :'shipToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'ship_to_format' => :'shipToFormat',
        :'balanced' => :'balanced',
        :'entered_by' => :'enteredBy',
        :'posted' => :'posted',
        :'customer' => :'customer',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'invoice_amount' => :'invoiceAmount',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'review' => :'review',
        :'po_number' => :'poNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'exported_to3rd_party' => :'exportedTo3rdParty',
        :'tax_base' => :'taxBase',
        :'tax_amount' => :'taxAmount',
        :'quantity_ordered' => :'quantityOrdered',
        :'charge_back_account' => :'chargeBackAccount',
        :'calculating' => :'calculating',
        :'commission_rate' => :'commissionRate',
        :'receivable' => :'receivable',
        :'target_sell' => :'targetSell',
        :'commission_base' => :'commissionBase',
        :'total_cost' => :'totalCost',
        :'actual_ship_date' => :'actualShipDate',
        :'invoice_num' => :'invoiceNum',
        :'debit_credit_reason' => :'debitCreditReason',
        :'discount_base' => :'discountBase',
        :'commission_amount' => :'commissionAmount',
        :'freight_amount' => :'freightAmount',
        :'discount_base_forced' => :'discountBaseForced',
        :'business_unit' => :'businessUnit',
        :'form_number' => :'formNumber',
        :'tax_distribution_source' => :'taxDistributionSource',
        :'distribute_tax' => :'distributeTax',
        :'invoice_level_options' => :'invoiceLevelOptions',
        :'sales_distribution_method' => :'salesDistributionMethod',
        :'tax_distribution_method' => :'taxDistributionMethod',
        :'sales_tax_basis' => :'salesTaxBasis',
        :'commission_distribution_method' => :'commissionDistributionMethod',
        :'commission_distribution_source' => :'commissionDistributionSource',
        :'value_added' => :'valueAdded',
        :'quantity_shipped' => :'quantityShipped',
        :'use_vat' => :'useVAT',
        :'distribution_remaining' => :'distributionRemaining',
        :'reversal_reason' => :'reversalReason',
        :'adjusted_invoice_amount' => :'adjustedInvoiceAmount',
        :'itemized' => :'itemized',
        :'lock_commission_amount' => :'lockCommissionAmount',
        :'deposit_amount' => :'depositAmount',
        :'handling_from_carton_content' => :'handlingFromCartonContent',
        :'quick_invoice' => :'quickInvoice',
        :'tax_base_adjustment' => :'taxBaseAdjustment',
        :'distribute_commission' => :'distributeCommission',
        :'invoice_batch' => :'invoiceBatch',
        :'send_as_pre_invoice' => :'sendAsPreInvoice',
        :'value_added_forced' => :'valueAddedForced',
        :'products_to_invoice' => :'productsToInvoice',
        :'previous_admin_status' => :'previousAdminStatus',
        :'tax_base_adjustment_forced' => :'taxBaseAdjustmentForced',
        :'lock_commission_base' => :'lockCommissionBase',
        :'freight_from_carton_content' => :'freightFromCartonContent',
        :'memo_approved' => :'memoApproved',
        :'next_line_num' => :'nextLineNum',
        :'balance_amount' => :'balanceAmount',
        :'submitted_to_onesource' => :'submittedToOnesource',
        :'memo_of' => :'memoOf',
        :'reversal_in_process' => :'reversalInProcess',
        :'taxing_failed' => :'taxingFailed',
        :'consolidation_group' => :'consolidationGroup',
        :'commission_base_adjustment_forced' => :'commissionBaseAdjustmentForced',
        :'split_from_invoice' => :'splitFromInvoice',
        :'close_job' => :'closeJob',
        :'previous_production_status' => :'previousProductionStatus',
        :'lock_customer_discount' => :'lockCustomerDiscount',
        :'tax_amount_adjustment' => :'taxAmountAdjustment',
        :'existing_memos' => :'existingMemos',
        :'percent_wip_to_relieve' => :'percentWipToRelieve',
        :'invoice_type' => :'invoiceType',
        :'partially_bill' => :'partiallyBill',
        :'taxing_required' => :'taxingRequired',
        :'commission_base_adjustment' => :'commissionBaseAdjustment',
        :'total_extras' => :'totalExtras',
        :'commission_amount_adjustment' => :'commissionAmountAdjustment',
        :'lock_tax_amount' => :'lockTaxAmount',
        :'post_completed' => :'postCompleted',
        :'parts_to_invoice' => :'partsToInvoice',
        :'lock_tax_base' => :'lockTaxBase',
        :'memo_accounting_period' => :'memoAccountingPeriod',
        :'line_item_total' => :'lineItemTotal',
        :'split_original_invoice_amount' => :'splitOriginalInvoiceAmount',
        :'memo_committed' => :'memoCommitted',
        :'memo_adjustment' => :'memoAdjustment',
        :'show_quick_invoice_report' => :'showQuickInvoiceReport',
        :'invoice_job_parts' => :'invoiceJobParts',
        :'invoice_amount_adjustment' => :'invoiceAmountAdjustment',
        :'posting' => :'posting',
        :'value_added_cost' => :'valueAddedCost',
        :'exclude_from_consolidation' => :'excludeFromConsolidation',
        :'commission_sales_category' => :'commissionSalesCategory',
        :'taxing_in_progress' => :'taxingInProgress',
        :'memo_date' => :'memoDate'
      }
    end
  end
end

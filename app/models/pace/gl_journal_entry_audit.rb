module Pace
  class GLJournalEntryAudit < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :bill_batch

    attr_accessor :bill

    attr_accessor :job_cost

    attr_accessor :inventory_line

    attr_accessor :bill_payment

    attr_accessor :asset_dep_batch

    attr_accessor :job_shipment

    attr_accessor :receivable

    attr_accessor :gl_journal_entry_source

    attr_accessor :receivable_line

    attr_accessor :payment_line

    attr_accessor :payroll_check_line

    attr_accessor :bill_line

    attr_accessor :gl_journal_entry

    attr_accessor :bill_check

    attr_accessor :payment

    attr_accessor :payroll_check

    attr_accessor :bank_account_line

    attr_accessor :asset_transaction_batch


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'bill_batch' => :'billBatch',
        :'bill' => :'bill',
        :'job_cost' => :'jobCost',
        :'inventory_line' => :'inventoryLine',
        :'bill_payment' => :'billPayment',
        :'asset_dep_batch' => :'assetDepBatch',
        :'job_shipment' => :'jobShipment',
        :'receivable' => :'receivable',
        :'gl_journal_entry_source' => :'glJournalEntrySource',
        :'receivable_line' => :'receivableLine',
        :'payment_line' => :'paymentLine',
        :'payroll_check_line' => :'payrollCheckLine',
        :'bill_line' => :'billLine',
        :'gl_journal_entry' => :'glJournalEntry',
        :'bill_check' => :'billCheck',
        :'payment' => :'payment',
        :'payroll_check' => :'payrollCheck',
        :'bank_account_line' => :'bankAccountLine',
        :'asset_transaction_batch' => :'assetTransactionBatch'
      }
    end
  end
end

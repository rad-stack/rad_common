module Pace
  class GLBatch < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :template_batch

    attr_accessor :last_journal_entry_source_notes

    attr_accessor :manual

    attr_accessor :balanced

    attr_accessor :entered_by

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :reversal_period

    attr_accessor :approved

    attr_accessor :balance

    attr_accessor :orginal_batch_id

    attr_accessor :last_journal_entry_reference1

    attr_accessor :reversal_date

    attr_accessor :date_time_setup

    attr_accessor :reverse_next_period

    attr_accessor :last_journal_entry_reference2

    attr_accessor :transaction_type

    attr_accessor :reversal

    attr_accessor :gl_accounting_period

    attr_accessor :original_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'date' => :'date',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'template_batch' => :'templateBatch',
        :'last_journal_entry_source_notes' => :'lastJournalEntrySourceNotes',
        :'manual' => :'manual',
        :'balanced' => :'balanced',
        :'entered_by' => :'enteredBy',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'reversal_period' => :'reversalPeriod',
        :'approved' => :'approved',
        :'balance' => :'balance',
        :'orginal_batch_id' => :'orginalBatchId',
        :'last_journal_entry_reference1' => :'lastJournalEntryReference1',
        :'reversal_date' => :'reversalDate',
        :'date_time_setup' => :'dateTimeSetup',
        :'reverse_next_period' => :'reverseNextPeriod',
        :'last_journal_entry_reference2' => :'lastJournalEntryReference2',
        :'transaction_type' => :'transactionType',
        :'reversal' => :'reversal',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'original_id' => :'originalId'
      }
    end
  end
end

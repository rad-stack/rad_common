module Pace
  class PaymentBatch < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manual

    attr_accessor :balanced

    attr_accessor :entered_by

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :approved

    attr_accessor :reversal

    attr_accessor :gl_accounting_period

    attr_accessor :bank_account

    attr_accessor :posting_method

    attr_accessor :balance_remaining

    attr_accessor :payment_reversal_note

    attr_accessor :legacy_batch

    attr_accessor :payment_total

    attr_accessor :original_batch_id

    attr_accessor :payment_count


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
        :'manual' => :'manual',
        :'balanced' => :'balanced',
        :'entered_by' => :'enteredBy',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'approved' => :'approved',
        :'reversal' => :'reversal',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'bank_account' => :'bankAccount',
        :'posting_method' => :'postingMethod',
        :'balance_remaining' => :'balanceRemaining',
        :'payment_reversal_note' => :'paymentReversalNote',
        :'legacy_batch' => :'legacyBatch',
        :'payment_total' => :'paymentTotal',
        :'original_batch_id' => :'originalBatchId',
        :'payment_count' => :'paymentCount'
      }
    end
  end
end

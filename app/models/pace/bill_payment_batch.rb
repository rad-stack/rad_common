module Pace
  class BillPaymentBatch < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :io_id1

    attr_accessor :entered_by

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :approved

    attr_accessor :reversal_date

    attr_accessor :date_time_setup

    attr_accessor :gl_accounting_period

    attr_accessor :amount_to_pay

    attr_accessor :adjustment_amount

    attr_accessor :discount_taken

    attr_accessor :printing_checks

    attr_accessor :bill_count


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'date' => :'date',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'io_id1' => :'ioID1',
        :'entered_by' => :'enteredBy',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'approved' => :'approved',
        :'reversal_date' => :'reversalDate',
        :'date_time_setup' => :'dateTimeSetup',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'amount_to_pay' => :'amountToPay',
        :'adjustment_amount' => :'adjustmentAmount',
        :'discount_taken' => :'discountTaken',
        :'printing_checks' => :'printingChecks',
        :'bill_count' => :'billCount'
      }
    end
  end
end

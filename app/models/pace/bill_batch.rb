module Pace
  class BillBatch < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :is_exported_to_third_party

    attr_accessor :manual

    attr_accessor :entered_by

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :approved

    attr_accessor :orginal_batch_id

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :gl_accounting_period

    attr_accessor :update_dates_on_bills


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
        :'is_exported_to_third_party' => :'isExportedToThirdParty',
        :'manual' => :'manual',
        :'entered_by' => :'enteredBy',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'approved' => :'approved',
        :'orginal_batch_id' => :'orginalBatchId',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'update_dates_on_bills' => :'updateDatesOnBills'
      }
    end
  end
end

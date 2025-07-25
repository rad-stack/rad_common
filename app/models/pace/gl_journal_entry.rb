module Pace
  class GLJournalEntry < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :component

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :entered_by

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :original_id

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :non_planned_reason

    attr_accessor :reference1

    attr_accessor :reference2

    attr_accessor :activity_code

    attr_accessor :account

    attr_accessor :receivable

    attr_accessor :business_unit

    attr_accessor :credit

    attr_accessor :debit

    attr_accessor :source_notes

    attr_accessor :gl_batch

    attr_accessor :jc_activity_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'date' => :'date',
        :'component' => :'component',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'entered_by' => :'enteredBy',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'original_id' => :'originalId',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'non_planned_reason' => :'nonPlannedReason',
        :'reference1' => :'reference1',
        :'reference2' => :'reference2',
        :'activity_code' => :'activityCode',
        :'account' => :'account',
        :'receivable' => :'receivable',
        :'business_unit' => :'businessUnit',
        :'credit' => :'credit',
        :'debit' => :'debit',
        :'source_notes' => :'sourceNotes',
        :'gl_batch' => :'glBatch',
        :'jc_activity_code' => :'jcActivityCode'
      }
    end
  end
end

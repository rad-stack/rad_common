module Pace
  class GLAccountingPeriod < Base
    attr_accessor :id

    attr_accessor :month

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :start_date

    attr_accessor :end_date

    attr_accessor :period_title

    attr_accessor :gl_period_status

    attr_accessor :must_run_tb_period

    attr_accessor :period_string

    attr_accessor :closing_period

    attr_accessor :accounting_period

    attr_accessor :fiscal_year


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'month' => :'month',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'start_date' => :'startDate',
        :'end_date' => :'endDate',
        :'period_title' => :'periodTitle',
        :'gl_period_status' => :'glPeriodStatus',
        :'must_run_tb_period' => :'mustRunTBPeriod',
        :'period_string' => :'periodString',
        :'closing_period' => :'closingPeriod',
        :'accounting_period' => :'accountingPeriod',
        :'fiscal_year' => :'fiscalYear'
      }
    end
  end
end

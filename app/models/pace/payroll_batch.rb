module Pace
  class PayrollBatch < Base
    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :posted

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :check_date

    attr_accessor :payroll_batch_id

    attr_accessor :begin_department

    attr_accessor :end_department

    attr_accessor :end_date_time

    attr_accessor :postable

    attr_accessor :reversable

    attr_accessor :pay_period

    attr_accessor :begin_date_time

    attr_accessor :gl_accounting_period_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'posted' => :'posted',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'check_date' => :'checkDate',
        :'payroll_batch_id' => :'payrollBatchID',
        :'begin_department' => :'beginDepartment',
        :'end_department' => :'endDepartment',
        :'end_date_time' => :'endDateTime',
        :'postable' => :'postable',
        :'reversable' => :'reversable',
        :'pay_period' => :'payPeriod',
        :'begin_date_time' => :'beginDateTime',
        :'gl_accounting_period_id' => :'glAccountingPeriodID'
      }
    end
  end
end

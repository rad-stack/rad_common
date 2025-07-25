module Pace
  class EmployeeTime < Base
    attr_accessor :id

    attr_accessor :hours

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :employee

    attr_accessor :approved

    attr_accessor :lunch_start

    attr_accessor :start_date_time

    attr_accessor :lunch_stop

    attr_accessor :department

    attr_accessor :payroll_pay_type

    attr_accessor :approved_by

    attr_accessor :pending_sign_out

    attr_accessor :stop_date_time

    attr_accessor :prhours


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'hours' => :'hours',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'employee' => :'employee',
        :'approved' => :'approved',
        :'lunch_start' => :'lunchStart',
        :'start_date_time' => :'startDateTime',
        :'lunch_stop' => :'lunchStop',
        :'department' => :'department',
        :'payroll_pay_type' => :'payrollPayType',
        :'approved_by' => :'approvedBy',
        :'pending_sign_out' => :'pendingSignOut',
        :'stop_date_time' => :'stopDateTime',
        :'prhours' => :'prhours'
      }
    end
  end
end

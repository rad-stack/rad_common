module Pace
  class EmployeeTimeSession < Base
    attr_accessor :id

    attr_accessor :start_time

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :employee_time

    attr_accessor :cost_center

    attr_accessor :plant_id

    attr_accessor :plant_manager_sign_in_machine_event_id

    attr_accessor :employee

    attr_accessor :plant_manager_sign_out_machine_event_id

    attr_accessor :stop_time

    attr_accessor :start_date

    attr_accessor :stop_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'start_time' => :'startTime',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'employee_time' => :'employeeTime',
        :'cost_center' => :'costCenter',
        :'plant_id' => :'plantId',
        :'plant_manager_sign_in_machine_event_id' => :'plantManagerSignInMachineEventId',
        :'employee' => :'employee',
        :'plant_manager_sign_out_machine_event_id' => :'plantManagerSignOutMachineEventId',
        :'stop_time' => :'stopTime',
        :'start_date' => :'startDate',
        :'stop_date' => :'stopDate'
      }
    end
  end
end

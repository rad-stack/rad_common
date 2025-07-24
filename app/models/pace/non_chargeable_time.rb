module Pace
  class NonChargeableTime < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :plant_manager_id

    attr_accessor :employee_time

    attr_accessor :cost_center

    attr_accessor :note

    attr_accessor :start_date_time

    attr_accessor :end_date_time

    attr_accessor :non_chargeable_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'plant_manager_id' => :'plantManagerId',
        :'employee_time' => :'employeeTime',
        :'cost_center' => :'costCenter',
        :'note' => :'note',
        :'start_date_time' => :'startDateTime',
        :'end_date_time' => :'endDateTime',
        :'non_chargeable_type' => :'nonChargeableType'
      }
    end
  end
end

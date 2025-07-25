module Pace
  class JobTracking < Base
    attr_accessor :id

    attr_accessor :start_time

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :start_date

    attr_accessor :inventory_item

    attr_accessor :activity_code

    attr_accessor :end_date

    attr_accessor :tracking_employee

    attr_accessor :tracking_hours

    attr_accessor :tracking_units

    attr_accessor :end_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'start_time' => :'startTime',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'start_date' => :'startDate',
        :'inventory_item' => :'inventoryItem',
        :'activity_code' => :'activityCode',
        :'end_date' => :'endDate',
        :'tracking_employee' => :'trackingEmployee',
        :'tracking_hours' => :'trackingHours',
        :'tracking_units' => :'trackingUnits',
        :'end_time' => :'endTime'
      }
    end
  end
end
